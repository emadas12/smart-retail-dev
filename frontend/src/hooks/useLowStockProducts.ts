import { useQuery } from "@tanstack/react-query";
import { Product } from "@/types";

const fetchLowStockProducts = async (): Promise<Product[]> => {
  const response = await fetch("http://localhost:5000/api/products/low-stock");
  if (!response.ok) {
    throw new Error("Network response was not ok");
  }

  const raw = await response.json();

  return raw.map((product: any) => ({
    id: product.product_id,
    name: product.name,
    sku: product.sku,
    stockLevel: product.stock_level,
    lowStockThreshold: product.low_stock_threshold,
    timestamp: product.timestamp,
    category: product.category ?? "",
    price: product.price ?? 0,
    cost: product.cost ?? 0,
    description: product.description ?? "",
  }));
};

export function useLowStockProducts() {
  return useQuery({
    queryKey: ["lowStockProducts"],
    queryFn: fetchLowStockProducts,
  });
}
