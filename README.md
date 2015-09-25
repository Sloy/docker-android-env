# Docker Android Env
Docker image for building android apps with gradle.

## What's included
- Ubuntu 15.10 as base image
- Oracle Java 8
- Android SDK
  - Build tools 23.0.1
  - Platform sdk 23 
- Pre-installed Gradle version 2.6 (you can ignore it and use your wrapper)

Emulators are not included since I don't currently need them. If you need them please open an issue and we'll discuss about it.

## Versioning (tags)
The tag format for the images is `XX.Y`, where XX points to the Android SDK version used, and Y is the image revision, which increases with every change that doesn't affect the SDK major version. I will hopefully document any changes with Github Releases.

The git repository uses branches for each sdk version, and tags (releases) for each image version. This means that specific image tags like "23.1" will always point to the same commit and won't change with time. Branches are published as `XX.latest`, meaning that tags like "23.latest" will point to the latest version published for that SDK.

If you use this docker image for CI, you probably want to use explicit tag versions to make sure that your build doesn't break by changes in the image.

I will try to keep the SDK versions up to date, but I might miss some updates or forget about them. If you see that there is a newer version available you can open an issue an I will gladly update the image.

## Contributing
Pull request and issues are welcome. If you need anything send a pull request or propose it with an issue and we will find the best way to integrate it.

## Disclaimer
I'm quite amateur with Docker. There might be better ways to do what I do. I'm open to suggestions and improvements, learning is my favorite hobby ;)
