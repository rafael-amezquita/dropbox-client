# Dropbox Client

This is a dropbox client aimed to test the dropbox api with an iOS application    

|<img src="https://github.com/rafael-amezquita/dropbox-client/blob/master/loginScreen.gif" width=300/>|<img src="https://github.com/rafael-amezquita/dropbox-client/blob/master/refreshingThumbs.gif" width=300/>|    
|<img src="https://github.com/rafael-amezquita/dropbox-client/blob/master/openPDF.gif" width=300/>|<img src="https://github.com/rafael-amezquita/dropbox-client/blob/master/emptyFolder.gif" width=300/>|    
|<img src="https://github.com/rafael-amezquita/dropbox-client/blob/master/openImage.gif" width=300/>|<img src="https://github.com/rafael-amezquita/dropbox-client/blob/master/unsuportedDoc.gif" width=300/>|    

## How to run it 

This project is using cocoapods, so please in the root run:    
```pod install```    
This will download Dropbox dependencies

## Known Issues

- User session is not being handled
- Currently updating thumbnails is taking a long time
- The data is requested every time the user selects a document, it can lead to a masive data consumption.