# Dropbox Client

This is a dropbox client aimed to test the dropbox api with an iOS application

## How to run it 

This project is using cocoapods, so please in the root run:    
```pod install```    
This will download Dropbox dependencies

## Known Issues

- User session is not being handled
- Currently updating thumbnails is taking a long time
- The data is requested every time the user selects a document, it can lead to a masive data consumption.