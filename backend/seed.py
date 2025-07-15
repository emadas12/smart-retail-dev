# backend/seed.py
from app import app, db
from models import Product, RestockLog, LowStockProduct
import requests
import json
from datetime import datetime

def seed_data():
    with app.app_context():
        print("Clearing existing products in local DB...")
        db.session.query(RestockLog).delete()
        db.session.query(LowStockProduct).delete()
        db.session.query(Product).delete()
        db.session.commit()
        print("Existing products in local DB cleared.")

        # --- Attempt to fetch data from Kubernetes Backend ---
        # Using 'host.docker.internal' to access services port-forwarded to your host.
        k8s_backend_url = "http://host.docker.internal:5000/api/products"
        print(f"Attempting to fetch products from Kubernetes backend: {k8s_backend_url}")
        
        products_to_add = [] # Initialize list for products to be added

        try:
            response = requests.get(k8s_backend_url, timeout=15) # Added a timeout for safety
            
            # Print diagnostic information regardless of success
            print(f"DEBUG: K8s Backend Response Status Code: {response.status_code}")
            print(f"DEBUG: K8s Backend Raw Response Text (first 500 chars): {response.text[:500]}...")

            response.raise_for_status() # Raise an exception for HTTP errors (4xx or 5xx)
            k8s_products_data = response.json()
            
            # Ensure the fetched data is a list, as expected
            if not isinstance(k8s_products_data, list):
                print(f"WARNING: K8s backend returned unexpected data type: {type(k8s_products_data)}. Expected a list. Treating as empty.")
                k8s_products_data = [] # Fallback to empty list if not a list

            print(f"Successfully parsed JSON. Fetched {len(k8s_products_data)} products from Kubernetes backend.")

            if not k8s_products_data:
                print("No products fetched from Kubernetes backend (or response was empty). Adding default sample data as fallback.")
                products_to_add = [
                    Product(name='Laptop Pro (Default)', sku='LAP-DEF', stock_level=50, category='Electronics', price=1200.0, cost=800.0, low_stock_threshold=10),
                    Product(name='Gaming Keyboard (Default)', sku='KB-DEF', stock_level=15, category='Peripherals', price=80.0, cost=40.0, low_stock_threshold=5),
                ]
            else:
                for p_data in k8s_products_data:
                    products_to_add.append(Product(
                        # Do NOT include 'id' if your database auto-generates primary keys.
                        name=p_data.get('name'),
                        sku=p_data.get('sku'),
                        stock_level=p_data.get('stock_level', 0),
                        category=p_data.get('category'),
                        price=p_data.get('price'),
                        cost=p_data.get('cost'),
                        low_stock_threshold=p_data.get('low_stock_threshold', 10)
                    ))

        except requests.exceptions.Timeout:
            print(f"ERROR: Request to {k8s_backend_url} timed out after 15 seconds.")
            print("Adding default sample data as fallback.")
            products_to_add = [Product(name='Timeout Product', sku='T-OUT', stock_level=1, category='Error', price=1.0, cost=1.0, low_stock_threshold=1)]
        except requests.exceptions.RequestException as e:
            print(f"ERROR: Failed to fetch products from Kubernetes backend ({k8s_backend_url}): {e}")
            print("Adding default sample data as fallback.")
            products_to_add = [Product(name='Fetch Error Product', sku='F-ERR', stock_level=1, category='Error', price=1.0, cost=1.0, low_stock_threshold=1)]
        except json.JSONDecodeError as e:
            print(f"ERROR: Failed to decode JSON from {k8s_backend_url}: {e}")
            # If JSON decoding fails, print the raw response text for debugging
            if 'response' in locals() and response.text:
                print(f"Problematic response text was: {response.text[:500]}...")
            print("Adding default sample data as fallback.")
            products_to_add = [Product(name='JSON Error Product', sku='J-ERR', stock_level=1, category='Error', price=1.0, cost=1.0, low_stock_threshold=1)]

        print(f"Inserting {len(products_to_add)} products into local DB...")
        for product in products_to_add:
            db.session.add(product)
            db.session.flush() # Flush to get product.id before adding LowStockProduct

            if product.stock_level <= product.low_stock_threshold:
                db.session.add(LowStockProduct(
                    product_id=product.id,
                    name=product.name,
                    sku=product.sku,
                    stock_level=product.stock_level,
                    low_stock_threshold=product.low_stock_threshold,
                    timestamp=datetime.utcnow()
                ))
        db.session.commit()
        print("Products seeded successfully in local DB.")

if __name__ == '__main__':
    seed_data()
