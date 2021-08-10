# BikeStationsFinder-iOS-App



## Runtime environment
<img src="https://img.shields.io/badge/Swift-5.3-orange.svg?style=flat" /> <img src="https://img.shields.io/badge/iOS-11.0-blue.svg?style=flat" /> <img src="https://img.shields.io/badge/Xcode-12.4-blue.svg?style=flat" /> <img src="https://img.shields.io/badge/MacOS-11.2.3-blue.svg?style=flat" />

## Technologies
<a href="https://developer.apple.com/swift/"> <img src="https://i.imgur.com/dYAJWbw.png" width="50" height="50" /> </a>
<a href="https://developer.apple.com/support/xcode/"> <img src="https://i.imgur.com/vDFUkmr.png" width="50" height="50" /> </a>
<a href="https://github.com/Alamofire/Alamofire"> <img src="https://i.imgur.com/ECSo5i8.png" width="50" height="50" /> </a>
<a href="https://www.json.org/json-en.html"> <img src="https://i.imgur.com/qwsouH3.png" width="50" height="50" /> </a>
<a href="https://github.com/peripheryapp/periphery"> <img src="https://i.imgur.com/xsawn5E.png" width="50" height="50" /> </a>
<a href="https://github.com/realm/SwiftLint"> <img src="https://i.imgur.com/avguXrc.jpg" width="85" height="50" /> </a>
<a href="https://github.com/SnapKit/SnapKit"> <img src="https://i.imgur.com/YrWcQOc.jpg" width="300" height="50" /> </a>

Another:
- animated loading dots: https://github.com/Abedalkareem/AMDots

## Table of contents
* [General info](#general-info)
* [Functionality](#functionality)
* [How to build](#how-to-build)

## General info

iPhone app for displaying bike stations in Poznań

## Functionality

- displaying stations as a list
- showing station on map
- showing distance between user and stations (real time)
- exact address only in map view (reverse geocoding CLGeocoder API calls limit)
- info about each station:
  - number of free bikes
  - number of free racks
  - distance between user and station
  - adress


  <p align="center"> <img src="Screenshots/screenshot1.png"{:height="20%" width="20%"} />
  		   <img src="Screenshots/screenshot2.png"{:height="20%" width="20%"} />
  		   <img src="Screenshots/screenshot3.png"{:height="20%" width="20%"} />
  		   <img src="Screenshots/screenshot4.png"{:height="20%" width="20%"} /> </p>

## How to build
In app main folder run:
```
pod install
```
After installing dependencies, you can run the project(`BikeStationsFinder.xcworkspace`).

## Demo
<p align="center"> <img src="Screenshots/demo.gif" {:height="30%" width="30%"} /> </p>
