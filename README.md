# ContinueTask

-Kindly, use software keyboard toggle for EMAIL text field text entering(for UI update).
-The Launch Manager maintains a User Defaults property to check whether the user has logged
in using Google once and sets Home View Controller as Root View Controller.

-(might require a reinstall if initially logged in with Google option.)

🧱 Project Structure

ViewController.swift
This is the initial view controller that welcomes users and presents them with two options:
"I have a device": Opens the login screen modally.
"I don’t have a device": Placeholder for future action.

LoginOptionsViewController.swift The modal login view. It includes:
A title and close button
Google and Apple login buttons
A decorative "or" section with dividers
An email field with a "Get OTP" button that appears when the user starts typing
Keyboard-aware layout using observers
A loader during authentication
Delegate callback to inform the presenting view controller on successful login
LoginSuccess Protocol Allows any presenting controller (like ViewController) to be notified when login is completed, so it can transition to the next screen (e.g., HomeViewController).
