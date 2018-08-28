# NVMultiProgressView
is a UIView developed for a an app plateform. It is a simple view-only progress bar that supports any number of progresses.

##  Including the project in Xcode

When adding this xcode project to a final app project with this method: https://www.raywenderlich.com/5109-creating-a-framework-for-ios
The module first couldn't be found, I had to rename the build configuration of the project from 'Debug' to the same name in the app project. And it worked.
I could then rename it back to 'Debug' and it still worked... but only until I changed my main project build configuration.
