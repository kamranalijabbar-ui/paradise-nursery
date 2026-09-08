import React from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { removeItem, updateQuantity } from './CartSlice';

function CartItem({ onContinueShopping }) {
  const cart = useSelector(state => state.cart.items);
    const dispatch = useDispatch();

      // Helper to parse costs like "$15" into integer 15
        const parseCost = (costString) => {
            return parseFloat(costString.replace('$', '')) || 0;
              };

                const calculateTotalAmount = () => {
                    return cart.reduce((total, item) => total + parseCost(item.cost) * item.quantity, 0);
                      };

                        const calculateTotalCost = (item) => {
                            return parseCost(item.cost) * item.quantity;
                              };

                                const handleIncrement = (item) => {
                                    dispatch(updateQuantity({ name: item.name, quantity: item.quantity + 1 }));
                                      };

                                        const handleDecrement = (item) => {
                                            if (item.quantity > 1) {
                                                  dispatch(updateQuantity({ name: item.name, quantity: item.quantity - 1 }));
                                                      } else {
                                                            dispatch(removeItem(item.name));
                                                                }
                                                                  };

                                                                    const handleRemove = (item) => {
                                                                        dispatch(removeItem(item.name));
                                                                          };

                                                                            const handleCheckoutShopping = () => {
                                                                                alert("Coming Soon");
                                                                                  };

                                                                                    return (
                                                                                        <div style={{ padding: '20px', maxWidth: '800px', margin: '0 auto' }}>
                                                                                              <h2 style={{ textAlign: 'center' }}>Total Cart Amount: ${calculateTotalAmount()}</h2>
                                                                                                    
                                                                                                          {cart.length === 0 ? (
                                                                                                                  <p style={{ textAlign: 'center' }}>Your cart is empty.</p>
                                                                                                                        ) : (
                                                                                                                                cart.map((item, index) => (
                                                                                                                                          <div key={index} style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', border: '1px solid #ddd', padding: '15px', borderRadius: '8px', marginBottom: '15px' }}>
                                                                                                                                                      <img src={item.image} alt={item.name} style={{ width: '80px', height: '80px', objectFit: 'cover', borderRadius: '6px' }} />
                                                                                                                                                                  <div>
                                                                                                                                                                                <h3>{item.name}</h3>
                                                                                                                                                                                              <p>Unit Price: {item.cost}</p>
                                                                                                                                                                                                            <p>Subtotal: ${calculateTotalCost(item)}</p>
                                                                                                                                                                                                                        </div>
                                                                                                                                                                                                                                    <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
                                                                                                                                                                                                                                                  <button onClick={() => handleDecrement(item)} style={{ padding: '5px 12px' }}>-</button>
                                                                                                                                                                                                                                                                <span>{item.quantity}</span>
                                                                                                                                                                                                                                                                              <button onClick={() => handleIncrement(item)} style={{ padding: '5px 12px' }}>+</button>
                                                                                                                                                                                                                                                                                          </div>
                                                                                                                                                                                                                                                                                                      <button onClick={() => handleRemove(item)} style={{ padding: '8px 12px', backgroundColor: '#e74c3c', color: 'white', border: 'none', borderRadius: '4px', cursor: 'pointer' }}>
                                                                                                                                                                                                                                                                                                                    Delete
                                                                                                                                                                                                                                                                                                                                </button>
                                                                                                                                                                                                                                                                                                                                          </div>
                                                                                                                                                                                                                                                                                                                                                  ))
                                                                                                                                                                                                                                                                                                                                                        )}

                                                                                                                                                                                                                                                                                                                                                              <div style={{ display: 'flex', justifyContent: 'space-between', marginTop: '20px' }}>
                                                                                                                                                                                                                                                                                                                                                                      <button onClick={onContinueShopping} style={{ padding: '10px 20px', backgroundColor: '#4CAF50', color: 'white', border: 'none', borderRadius: '4px', cursor: 'pointer' }}>
                                                                                                                                                                                                                                                                                                                                                                                Continue Shopping
                                                                                                                                                                                                                                                                                                                                                                                        </button>
                                                                                                                                                                                                                                                                                                                                                                                                <button onClick={handleCheckoutShopping} style={{ padding: '10px 20px', backgroundColor: '#2196F3', color: 'white', border: 'none', borderRadius: '4px', cursor: 'pointer' }}>
                                                                                                                                                                                                                                                                                                                                                                                                          Checkout
                                                                                                                                                                                                                                                                                                                                                                                                                  </button>
                                                                                                                                                                                                                                                                                                                                                                                                                        </div>
                                                                                                                                                                                                                                                                                                                                                                                                                            </div>
                                                                                                                                                                                                                                                                                                                                                                                                                              );
                                                                                                                                                                                                                                                                                                                                                                                                                              }

                                                                                                                                                                                                                                                                                                                                                                                                                              export default CartItem;
                                                                                                                                                                                                                                                                                                                                                                                                                              