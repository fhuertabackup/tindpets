import pytest
from src.services.checkout_service import get_checkout_service

def test_checkout_with_100_percent_discount():
    checkout_service = get_checkout_service()
    order_data = {
        "items": [{"name": "test", "price": 100}],
        "total_price": 100,
        "discount_percentage": 100,
    }
    
    result = checkout_service.process_checkout(order_data)
    
    assert result["status"] == "success"
    assert result["order"]["final_price"] == 0

# Add a test for a typical discount scenario to ensure it still works
def test_checkout_with_partial_discount():
    checkout_service = get_checkout_service()
    order_data = {
        "items": [{"name": "test", "price": 100}],
        "total_price": 100,
        "discount_percentage": 10,
    }
    
    result = checkout_service.process_checkout(order_data)
    
    assert result["status"] == "success"
    assert result["order"]["final_price"] == 90
