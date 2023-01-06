# CatsBag
Shopping list app SwiftUI + CoreData

## Description of project navigation

- Root File:

  - CatsBagApp - @main.

- View folder:

  - ContentView - root view to get access to tree of views(FolderView -> ItemView -> Add/UpdateItemView).

  - FolderView - view with list of folders and navigationLink to ItemView.

  - ItemView - view with list of items.

  - AddItemView - view with text fields and pickers to set up item properties.

  - UpdateItemView - view with text fields and pickers to change item properties.

- ViewModel folder:

  - PersistenceController - controller to get access to CoreData container.

  - ViewModel - class that contains all the methods to manage the views and data model.

## Stack

SwiftUI

CoreData

MVVM

<p float="left">
<img src="https://user-images.githubusercontent.com/97796448/210278695-8145195a-24e6-4b4a-9359-7ee9af1499cb.mp4" width="390" height="844">
</p>
