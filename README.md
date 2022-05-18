## Build tools & versions used
Xcode 12.2.1

## Steps to run the app
Select a device in the list of simulators and press run. No special steps are necessary

## What areas of the app did you focus on?
I focused on the architecture mainly, and tried to implement a good example of MVVM. If there were more screens or more time, I would also add a Coordinator layer for navigation flow.

## What was the reason for your focus? What problems were you trying to solve?
SOLID architecture laid out in the beginning of a project makes adding additional functionality and scope much easier, faster and less buggy in the future. It makes it easier for other developers to engage with a mew project as well, because its laid out in a standardized way.

## How long did you spend on this project?
I spent around 8 hours which was the suggested max, maybe a little more. This was for several reasons. In order to meet all the requirements which included writing production ready code, more than 4-6 hours was needed. I also spent extra time architecting the app when a simple MVC approach would technically suffice if the requirements were taken at face value. I enjoy the architecture process and I had fun building the app, so it became more of a fun project that I was happy to spend time on. 

## Did you make any trade-offs for this project? What would you have done differently with more time?
Im happy to say I dont feel that I made any trade offs in terms of quality due to time constraints, but rather I was able to leave the app in a working and extensible state, so that features not fully fleshed out are able to be easily expanded. For instance, the UI is in place but by no means in a final draft state, but with more time it can easily be made to look professional. I also did not implement the Coordinator layer as it was just technically out of scope given it was reiterated that we only use one screen, however a Coodinator could be easily added at this point if we wanted to add additional functionality. Unit testing - I would include a full suite of unit tests given more time as well. 
The empty state and error states are not built out however the foundation is there for them to be easily implemented. Also there is a preliminary sort functionality that can be expanded.

## What do you think is the weakest part of your project?
The weakest part is the UI - it works, does what its supposed to, but its not very impressive. This is simply due to time constraints. Unit testing is also weak for the same reason. Normally writing these tests would be made as part of the alotted time, however there was not enough time to both build a working product that met the requirements that could be tested, and the tests themselves. 

## Did you copy any code or dependencies? Please make sure to attribute them here!
Snapkit for contraints
Kingfisher for image caching and loading

## Is there any other information you’d like us to know?
Thank you for the opportunity to build this example app for you. I really enjoyed it, I love building out apps and features from the ground up like this. 

Ive included the initial design for the app I created in LucidChart. It changed over the course of building out the app but it helped serve as the initial foundation for how I wanted to lay out it. I know its a simple one screen tableview app but I find this sort of thinking helpful anyway, and also fun.

![flowchart](/../master/directory_flowchart.png?raw=true "Architecture")

