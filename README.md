# **Fetch Recipe App**  

## **📌 Summary**  
Fetch Recipe App is a **SwiftUI-based iOS application** that displays a list of recipes retrieved from an API. The app features **smooth animations, image caching, error handling, and a beautiful launch screen**. It follows best practices for **Swift Concurrency (async/await)**, **unit testing**, and **clean architecture**.  

### **🚀 Features**
- Displays **recipe name, cuisine type, and images**.  
- **Smooth animated launch screen** with a **5-second delay** before transitioning to the main screen.  
- **Pull-to-refresh functionality** to reload recipes dynamically.  
- **Image caching** using `NSCache` and **disk caching** for optimized network usage.  
- **Error handling** for empty or malformed data, ensuring a seamless user experience.  
- **Unit & UI tests** for network calls, image caching, and user interactions.  

---

## **🎯 Focus Areas**
1. **Efficient Network Usage**  
   - Implemented **async/await** for all API calls.  
   - **Disk-based image caching** to reduce redundant network requests.  
   - Images are **loaded only when needed**, improving performance.  

2. **Robust Error Handling**  
   - Discards entire recipe list when malformed data is encountered.  
   - Displays an **empty state** when no recipes are available.  
   - Handles network failures gracefully.  

3. **Seamless User Experience (UI/UX)**  
   - **Modern, elegant launch screen** with animations.  
   - **Clean and structured list view** for recipes.  
   - **Buttons for YouTube and Recipe Source** links on the detail screen.  

---

## **🕒 Time Spent (Total: ~4 Hours)**
| Task | Time Spent |
|-------|-----------|
| Project setup & API integration | **1 hour** |
| Swift Concurrency (async/await) | **30 minutes** |
| Image caching (memory + disk) | **45 minutes** |
| UI Design & Animations | **45 minutes** |
| Error handling & testing | **30 minutes** |
| UI Testing & Debugging | **30 minutes** |

---

## **⚖️ Trade-offs & Decisions**
1. **Used `NSCache` + Disk Caching** instead of relying on `URLSession`'s built-in caching for better control over image persistence.  
2. **No external dependencies** were used, following Fetch's requirement to use only Apple's native frameworks.  
3. **UI prioritization**: Focused on simplicity while ensuring **smooth animations & a responsive layout**.  

---

## **🚧 Weakest Part of the Project**
- UI testing **could be improved** with better handling for dynamic delays in network responses.  
- Could add **pagination** to improve performance for large datasets.  

---

## **📌 Additional Information**
- **SwiftUI environment object** is used for dependency injection, making it easy to switch between **Mock API** and **Real API**.  
- Implemented **separate unit tests** for:
  - **Network calls**
  - **Image caching**
  - **Error handling**
  - **UI interactions**  
- UI layout is **fully responsive** and works across all iPhone screen sizes.  

---

## **📸 Screenshots & Video**
<p align="center">
<img width="411" alt="Screenshot 2025-02-10 at 8 42 55 PM" src="https://github.com/user-attachments/assets/21f2ad60-e20b-469c-bc4b-6ea62a6ad0f5" />
<img width="411" alt="Screenshot 2025-02-10 at 8 43 12 PM" src="https://github.com/user-attachments/assets/4b3f3735-a591-4c62-a5c6-cb91e6ef17e9" />
</p>

https://github.com/user-attachments/assets/5e3bb948-472c-41ff-8f14-01cc55d34b92


---

