## CookWhat iOS

The most amazing app that allows users to get what they should cook tonight.

### System requirements

* Xcode 8.x
* CocoaPods 1.1.1
* Ruby 2.4.0

### Setup

#### Install CocoaPods

```
gem install cocoapods
```

#### Install libraries

```
pod install
```

### Run on your iPhone

#### open the project. Be careful not to open `CookWhat.xcodeproj`.

```
cd /to/project/directory/
open CookWhat.xcworkspace
```

#### Modify Signing setting.

* in Xcode opening the project, click `CookWhat` on left nav, then you can see `PROJECT`, `TARGETS`.

* Click `CookWhat` in `TARGETS`, then you can see several config items.

* there, you can see `Signing` item. click `Team` select box and select yourself(maybe you can choose apple ID).

#### Run.

* on top-left side of the Xcode window, you can see something like `CookWhat > iPhone 7`. click it and change to `CookWhat > your-iPhone-name`.

* `Command + R`.

#### Modify security setting on your iPhone.

* with above steps, maybe you cannot run the app because of security risk. in your iPhone, open `Settings` -> `General` -> `Profile & Device management`.

* you can see there is your name as `Developer APP`. tap it and tap `Trust this`. then you can open the app.

* this step is needed only first time.
