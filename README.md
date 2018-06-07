# Handwriting-recogniser

It is an app that I made to test my MLModel I created using the CreateML framework released by Apple during WWDC'18

# About the MLModel

I trained this model using [The Chars74K dataset](http://www.ee.surrey.ac.uk/CVSSP/demos/chars74k/) with the accuracy to over 85%

The model is super light-weight (around 800KBs)

# About the App

One can draw English Letters on a 300x300px UIImageview which is then sent to the Model, and the Model then tries to predicts the English Alphabet written.

The image being an UIImage is first converted to CIImage then to CGImage before being sent to the MLModel.

# Created By

The app and the model was created by myself, and the inspiration for the app was from a WWDC scholarship submission by [Sameer Saxena](https://github.com/saxes20/WWDC2018Application/)