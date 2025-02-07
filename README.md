# Setu: Bridging Communication Between ISL and Non-ISL Users

Setu is an innovative application designed to break communication barriers by connecting individuals from the deaf and mute communities with the broader society. Through real-time translation between Indian Sign Language (ISL) and text, Setu empowers ISL speakers to interact effortlessly with family members, educators, healthcare professionals, employers, and more.

---

## Table of Contents

- [Introduction](#introduction)
- [Core Features](#core-features)
  - [1. ISL-to-Text Translation](#1-isl-to-text-translation)
  - [2. Text-to-ISL Translation](#2-text-to-isl-translation)
  - [3. Interactive ISL Dictionary](#3-interactive-isl-dictionary)
  - [4. Educational Content](#4-educational-content)
- [Technical Methodology](#technical-methodology)
- [Future Enhancements](#future-enhancements)
- [Three Focus Areas](#three-focus-areas)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)
- [Acknowledgements](#acknowledgements)

---

## Introduction

Setu connects ISL users with non-ISL users by translating ISL gestures into text and vice versa. This application significantly reduces communication barriers and fosters greater inclusion in everyday interactions. Whether for personal communication or professional engagements, Setu ensures that ISL speakers can participate fully in society.

---

## Core Features

### 1. ISL-to-Text Translation

- **Real-Time Gesture Recognition:**  
  Utilizes any device camera to capture user gestures in real time.
- **Advanced Computer Vision:**  
  Employs YOLO v9 for precise object detection and gesture recognition.
- **Deep Learning Interpretation:**  
  Uses a Convolutional Neural Network (CNN) to convert recognized gestures into text.
- **Text-to-Speech Integration:**  
  Provides the option to display the translated text on-screen or read it aloud.
- **Continuous Model Improvement:**  
  Regular updates to the deep learning model enhance accuracy and adapt to new ISL gestures.

### 2. Text-to-ISL Translation

- **Dual Translation Capability:**  
  Converts written or spoken language into ISL, making communication two-way.
- **3D Animated Avatars:**  
  Features a custom animated model created with Blender that accurately captures facial expressions and body gestures essential for ISL.
- **Augmented Reality (AR) Mode:**  
  Superimposes ISL signs onto real-world objects, offering an immersive and context-driven learning experience.

### 3. Interactive ISL Dictionary

- **Comprehensive Sign Library:**  
  A full-featured dictionary allowing users to look up ISL signs with ease.
- **Video Demonstrations:**  
  Includes video guides for words, phrases, and idioms to illustrate proper sign usage.
- **Regional and Contextual Variants:**  
  Provides information on regional sign differences and contextual usage.
- **Personalized Learning:**  
  Features bookmarking, progress tracking, and review capabilities to assist in learning.

### 4. Educational Content

- **Diverse Learning Materials:**  
  Offers a library of videos, interactive lessons, and quizzes curated by experienced ISL educators.
- **Gamified Quizzes:**  
  Engages users with a points and badge system to motivate continuous learning.
- **3D Conversation Simulation:**  
  A practice module that simulates conversations with a 3D avatar, building confidence for real-world interactions.

---

## Technical Methodology

- **Machine Learning Integration:**  
  Setu leverages YOLO v9 for rapid gesture detection and a CNN for classifying these gestures, ensuring swift and precise ISL-to-text translation.
- **3D Modeling and Animation:**  
  Blender is used to create high-fidelity animated models that faithfully replicate the subtleties of ISL gestures.
- **Augmented Reality:**  
  AR technology is incorporated to merge digital ISL signs with the physical world, enhancing user immersion and interaction.

---

## Future Enhancements

- **Virtual Reality (VR) Integration:**  
  Future updates may include VR capabilities to facilitate virtual meetings and immersive classrooms.
- **Real-Time 3D Avatars in Broadcasts:**  
  Development of dynamic 3D avatars for live translation during movies, news broadcasts, and other multimedia formats.
- **Personalized Avatars:**  
  Allowing users to customize their avatars to create a more personalized and engaging experience.

---

## Three Focus Areas

1. **Live ISL-to-Text Translation:**  
   Ensuring seamless, real-time communication.
2. **Text-to-ISL Translation with 3D Avatars & AR Support:**  
   Bridging the communication gap with innovative visual translation.
3. **Rich Educational Resources:**  
   Offering a robust learning platform to encourage the use of ISL and foster interaction among all users.

---

## Getting Started

### Prerequisites

- **Device Requirements:**  
  A device equipped with a camera for gesture detection.
- **Operating System:**  
  Compatible with Windows, macOS, and Linux.
- **Internet Connection:**  
  Required for accessing AR features and cloud-based services.

### Installation

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/yourusername/setu.git
