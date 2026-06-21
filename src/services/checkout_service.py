from typing import Dict, Any

class CheckoutService:
    def process_checkout(self, order_data: Dict[str, Any]) -> Dict[str, Any]:
        total_price = order_data.get("total_price", 0)
        discount_percentage = order_data.get("discount_percentage", 0)

        if discount_percentage == 100:
            final_price = 0
        else:
            final_price = total_price * (1 - discount_percentage / 100)

        if final_price < 0:
            # Original validation might have prevented zero or negative prices
            raise ValueError("Validation Error: Final price cannot be negative.")
        
        order_data["final_price"] = final_price
        # Simulate further processing
        return {"status": "success", "order": order_data}

def get_checkout_service() -> CheckoutService:
    return CheckoutService()
