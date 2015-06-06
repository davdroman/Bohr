<p align="center">
	<img src="Assets/header.png" alt="Header" width="500px" />
</p>

Bohr allows you to set up a settings screen for your app with three principles in mind: ease, customization and extensibility.

<p align="center">
	<img src="Assets/1.gif" alt="GIF 1" width="320px" />
</p>

By default, Bohr supports multiple setting types such as strings, booleans or times. However, this framework has been built focusing a lot of attention in extensibility, meaning you can build your own custom classes to support any kind of setting type you want.

#### Why "Bohr"?

"Bohr" comes from Neils Bohr, conceiver of an atomic model which introduces the concept of electronic ___configuration___, a way to organize electrons by layers around the atom nucleus.

True story.

## Installation

#### Carthage

```
github "Dromaguirre/Bohr"
```

#### CocoaPods

```ruby
pod 'Bohr'
```

#### Manual

Drag and copy all files in the [__Bohr__](Bohr) folder into your project.

## At a glance

#### Setup

The settings screen you're going to set up is represented by a `UITableViewController` subclass called `BOTableViewController`. Such controller manages `BOTableViewSection` instances, which manages a set of `BOTableViewCell` instances.

All you need to start building your settings screen is a `BOTableViewController` (or subclass) instance, which you'll initialize:

```objective-c
BOTableViewController *tableViewController = [[BOTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
```

_Note: you may use `UITableViewStylePlain` too, but keep in mind most apps use `UITableViewStyleGrouped`_.

Next, we'll add a section to our view controller:

```objective-c
BOTableViewSection *section = [BOTableViewSection sectionWithTitle:@"My section"];
[tableViewController addSections:@[section]];
```

_Note: you may add your sections and cells in a subclass of `BOTableViewController`. In case you decide to do so, there's a `setup` method where you can, well... do the setup._

And finally, we'll add some cells to our section (for the sake of simplicity, I'll add just one):

```objective-c
BOSwitchTableViewCell *switchCell = [BOSwitchTableViewCell cellWithTitle:@"Switch option" setting:[BOSetting settingWithDefaultValue:@YES forKey:@"key_for_bool_option"]];
[section addCells:@[switchCell]];
```

_Note: `BOSetting` is a simple object that defines the setting the cell will represent through a `key` and a `value` property. It also takes care of some business to make the `NSUserDefaults` logic layer easier to manage, but you don't need to worry about that at all._

#### Built-in BOTableViewCell's

As mentioned before, there's a bunch of built-in BOTableViewCell subclasses ready to be used:

- `BOSwitchTableViewCell`: manages `BOOL` values through a `UISwitch` control.
- `BOTextTableViewCell`: manages `NSString` values through a `UITextField` control.
- `BOChoiceTableViewCell`: manages `NSInteger` values (which you can understand as "options" from a `NS_ENUM`) through taps on the cell itself.
- `BOTimeTableViewCell`: manages `NSInteger` values that represent a given time as the minute interval from midnight to such time. A revealing `UIPickerView` is used to set the time.
- `BODisclosureTableViewCell`: this cell is used to pushes a view controller from the current one. Note your `BOTableViewController` needs to be embedded in a `UINavigationController` in order for this cell to work.
- `BOButtonTableViewCell`: allows the user to perform an action when the cell is tapped.

Again, this framework is all about extensibility, so if you want to provide your own implementation for any kind of setting type you can. Read below to know how.

#### Subclassing BOTableViewCell

Creating a subclass of BOTableViewCell is fairly straighforward.

First of all, the framework contains a header file called `BOTableViewCell+Subclass.h`. You must import that header in your subclass implementation file. That way, you'll be able to access all the necessary methods for you to implement them in your subclass:

- `setup`: used to set up the cell for the first time.
- `updateAppearance`: any code that defines the appearance of the cell should be put here. Note every `BOTableViewCell` instance contains 4 properties used to define its style:
	- `mainColor`: the color used for the title and other main elements of the cell.
	- `mainFont`: the font used for the title and other main elements of the cell.
	- `secondaryColor`: the color used for the detail text and other secondary elements of the cell.
	- `secondaryFont`: the font used for the detail text and other secondary elements of the cell.
- `wasSelectedFromViewController:`: called when the cell is tapped. The `BOTableViewController` where the cell is contained is passed.
- `settingValueDidChange`: called when the `NSUserDefault` value associated with the cell changes. You must represent such change in the visual element of your cell. Accessing that new value is as simple as calling `self.setting.value`.

There's also a property called `expansionHeight`. If you set that property (preferably in `setup`), the cell height will be expanded when tapped. That extra height is determined by `expansionHeight` itself. As a side note, you shouldn't override `wasSelectedFromViewController:` if you set `expansionHeight`, and if you do, please make sure to always call `super`.

Please take a look to the implementation code of `BOSwitchTableViewCell` for a more detailed demonstration on how to subclass `BOTableViewCell`.

## License

Bohr is available under the MIT license.