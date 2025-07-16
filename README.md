# NutriWise 🍽️📱

**NutriWise** is a modern mobile application designed to help users manage their dietary habits in a conscious and personalized way. Through features such as meal tracking, water consumption monitoring, calorie analysis, and AI-powered suggestions, NutriWise acts as a smart companion in your journey toward a healthier lifestyle.

---

## 📱 Features

### 🔍 Core Features
- 📷 **Food Recognition (CoreML):** Identify food items using AI-powered image recognition and instantly fetch their nutritional values.
- 🍽️ **Meal Planning & Tracking:** Log meals by type (breakfast, lunch, dinner, snacks).
- 🧮 **Calorie & Macronutrient Calculation:** Monitor calories, protein, fats, and carbs.
- 💧 **Water Challenge Module:** Track your daily hydration visually.
- 🧑‍⚕️ **AI Nutrition Coach:** Get personalized daily and weekly meal recommendations.
- 📈 **Weight Tracking & Graphs:** Track progress with interactive charts.
- 👤 **Personal Profile Management:** Manage physical data and diet goals.

---

## 🧠 AI Integration

NutriWise integrates **CoreML** to allow users to take pictures of their meals. The AI model detects and identifies food, estimates nutritional values, and adds them to the user’s meal log with one tap.

---

## 🏠 Home Screen Overview

- Daily calorie target and remaining calories
- Macronutrient breakdown (fat, protein, carbs)
- Visual water intake progress
- Meal-based calorie summaries

---

## 🧑‍🏫 AI Coach Page

- Daily calorie deviation and nutrition tips
- Health alerts
- Suggested meals
- Weekly meal plan overview

---

## 🔐 User Onboarding & Personalization

During registration, users provide:
- Name, gender, age, height, weight
- Goal weight and preferred pace
- The app then calculates personalized calorie goals and health plans.

---

## 🧑‍💻 Tech Stack & Backend Architecture

### 🧱 Technologies
- **Backend:** ASP.NET Core Web API
- **Frontend:** Swift (iOS)
- **Database:** Entity Framework Core (EF Core)
- **AI:** CoreML (Apple’s machine learning framework)

### 🗂️ Backend Structure

#### ✅ User Management
- `User`: Represents the database entity.
- `UserDto`: Transfers data between frontend and backend.
- `UserRepository`: Handles EF Core data operations.
- `IUserService`: Defines business logic methods (register, login, delete).
- `UserService`: Implements core business logic securely (password hashing, BMI calculation).

#### 🍎 Food Management
- `Food`: Entity representing food items and nutrients.
- `FoodService`: Handles CRUD operations with DTO mapping.
- `FoodController`: RESTful API endpoints.

#### 🍽️ Meal Management
- `Meal`: Entity tracking meal types and food items per date.
- `MealService`: Implements meal-related business logic.
- `MealController`: Exposes endpoints like `/meal/user/{id}`, `/meal/daily/{id}`.

#### 🔢 Calorie Calculations
- `CalorieService`: Calculates BMR, calorie goals, and daily totals.
- 

## Images From Application 

<img width="172" height="372" alt="image" src="https://github.com/user-attachments/assets/3da0ae5b-6f37-478b-8e70-c8c2a2b47250" /> <img width="172" height="372" alt="image" src="https://github.com/user-attachments/assets/70ee18e5-eb87-473d-b291-a0d107b73502" />
<img width="212" height="364" alt="image" src="https://github.com/user-attachments/assets/03e4a614-9f61-463d-90de-82ef659a9bf3" /> <img width="212" height="364" alt="image" src="https://github.com/user-attachments/assets/85f4db63-6255-48b2-a9a9-547f455abbc0" /> <img width="211" height="364" alt="image" src="https://github.com/user-attachments/assets/d1dd7cf1-5621-48aa-803b-5fe4e3560cea" /> <img width="212" height="364" alt="image" src="https://github.com/user-attachments/assets/2ec2e0a8-418f-4677-86a7-135bf24aa86a" />
<img width="201" height="435" alt="image" src="https://github.com/user-attachments/assets/72161e33-6b63-4d65-bde9-68907fba27f6" /> <img width="152" height="329" alt="image" src="https://github.com/user-attachments/assets/809b6b6f-ee6f-47c4-8b77-52b936c42bb0" />
<img width="172" height="372" alt="image" src="https://github.com/user-attachments/assets/8364e3bf-a1a2-48f3-a306-ad5b04c81a37" /> <img width="172" height="372" alt="image" src="https://github.com/user-attachments/assets/db03b453-eaea-46eb-bd62-913aa5c5c453" />
<img width="232" height="409" alt="image" src="https://github.com/user-attachments/assets/4de87a6d-ab21-4094-937e-9fba25c8d738" /> <img width="232" height="409" alt="image" src="https://github.com/user-attachments/assets/e884727c-793a-4049-accb-f6533ad42106" /> <img width="203" height="438" alt="image" src="https://github.com/user-attachments/assets/81ca0c96-2dff-4145-b07d-5df6a9274c24" />




## Features I Used

-> FirebaseAuth

-> FirebaseFirestore

-> MVVM Design Pattern

-> TableView

-> Custom Cell

-> Alert Messages
