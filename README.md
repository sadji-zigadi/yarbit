# Yarbit client side

## 1. Project Description

The client side of Yarbit is a mobile application written in Flutter. Although Flutter is cross-platform, this app is only intended to work on Android.

## 2. Architecture



This app is written following the **Clean Architecture** principles. The app is divided into three main layers:

1. **Presentation**: This layer is responsible for the UI of the app. It contains the widgets and the logic to display the data to the user. It containts three subfolders:

   1.1. **pages**: Contains the pages of the app.
    
   1.2. **widgets**: Contains the widgets used in the pages.
    
   1.3. **bloc** or **controller**: Contains the BLoC classes used to manage the state of the app.

2. **Data**: This layer is responsible for the data of the app. It contains the classes to interact with the database and the API. It contains three subfolders:

   2.1. **models**: Contains the classes to represent the data.
    
   2.2. **repositories**: Contains the classes to interact with the database and the API.
    
   2.3. **datasources**: Contains the classes to interact with the API.

3. **Domain**: This layer is responsible for the business logic of the app. It contains the classes to interact with the data layer. It contains three subfolders:

   3.1. **entities**: Contains the classes to represent the entities.
    
   3.2. **usecases**: Contains the classes to interact with the data layer.
    
   3.3. **repositories**: Contains the interfaces to interact with the data layer.

The picture below summarizes how the three layers interact with each other:

![Clean Architecture](https://miro.medium.com/v2/resize:fit:1112/0*zUtZYiJ1bDTugOYY)

Every entity in the app extends a mixin named `EntityStructure` that defines the strucutre that every entity should follow, so every entity has the same strucutre. Same thing goes for the models, every model extends an entity so that they have the same fields and extends a mixing named `ModelStructure` so that every model has the same strucutre. All entities extends an `Equatable` which is from a package named `equatable` that makes it easier to compare if two objects are equal by comparing the value of their fields.

## 3. Features

The app folder structure is divided following the feature-based division principle. Each feature of the app is divided into the three main mentioned above. The features of the app are:

1. **Authentication feature**: This feature is responsible for the authentication of the user.

   Following the clean architecture here are the layers of the app:

   1. **Domain layer**:

      1. **Entities**:

         - `ClientEntity`: This is the entity responsible of the user connected to the device. It contains these attributs:

            - `id` | `String`: which is the unique identifier of the client.
            - `email` | `String`: which is the unique email of the client.
            - `name` | `String`: which is the name of the client.
            - `address` | `Map<String, dynamic>`: it is a map composed of two keys `wilaya` and `commune` that represent the address of the client.
            - `phoneNum` | `String`: which is the phone number of the user.
            - `pictureUrl` | `String`: which is the profile picture url of the user.

      2. **Usecases**:

         - **Login**: This use case is responsible for the login of the user. It takes as input the email and password of the user so that he can connect to the app, and it returns a `ClientEntity` which is the entity of the user connecting.
         
         - **Sign up**: This use case is responsible for the registration of the user. It takes as input the name, the email and the password of the user, it creates the account in firebase and returns a `ClientEntity`.
            
         - **Forgot password**: This use case is responsible for the password recovery of the user. It takes the email as input and then it will send an email with a link so that he can reset his password.
         
         - **Set details**: This use case is responsible for the user to set his additional information that are requried.. It takes the wilaya, the commune and the phone number as input and it will take care of both storing them locally and make the appropriate changes in the backend.

         - **Get profile info**: This use case is responsible of getting the profile information of the user connected to the app, it does this by accessing the local database of the device.

         - **Is auth**: This use case is responsible of knowing if the user was previously connected to the app using the same device or not. It is helpful when it comes to the initial routing.

         - **Sign out**: This use case is responsible of signing out of the app. It will inform the backend of the signing out and clears the local database.

         - **Edit profile info**: This usecase is responsibe of editing the profile information which are; the name, the phone number, the email, the password and the image.

         - **Get profile info**: This usecase is responsible of loading the profile information (name, phone number, email and the image).
      
      3. **Repositories**:
         
         - **Auth repository**: It has all the usecases mentionned above.
   
   2. **Data layer**:

      1. **Models**:

         - `ClientModel`: which is the basic model that connects with the datasources. It is annotated with `@HiveType(typeId:1)` which is a package named `hive` which is a local database.
      
      2. **Repositories**:

         - **Auth repository implemenation**: which is the implementation of the auth repository, it has 3 objects dependency injection which are `AuthRemoteDatasource`, `AuthLocalDatasource` and `NetworkInfo`. The first two are datasources that connect with the remote datasource (Firebase) and the local database (Hive) and the third one uses a class `NetworkInfo` that check if the device is connected to the internet. It check it by using a third pary package named `InternetConnectionChecker`.
      
      3. **Datasources**:

         - **Auth remote data source**: which has `FirebaseAuth` and `FirebaseFirestore` as dependency injection, and has the methods:

            - `signUp`: which takes as input the `name` | `String`, `email` | `String` and `password` | `String` and returns a `ClientModel` after successfully creating the account and logs in.

            - `logIn`: which takes as input the `email` | `String`, `password` | `String` and returns a `ClientModel` after successfully connecting the user.

            - `setDetails`: which takes as input the wilaya `wilaya` | `String`, `commune` | `String` and `phoneNum` | `String`, it will make the appropriate changes in the backend.

            - `forgetPassword`: takes the `email` | `String` as input and sends an email to change the password on the email.

            - `signOut`: signs out the user.
            
            - `editName`: It takes a `name` | `String` as input and stores it in the backend.

            - `editPhoneNumber`: It takes a `phoneNumber` | `String` as input and stores it in the backend.

            - `editEmail`: It takes a `email` | `String` as input stores it in the backend and changes the authentication email.

            - `editPassword`: It takes a `password` | `String` as input changes the authentication password.

            - `editImage`: It takes a, `image` | `File` as input changes the picture of the authenticated user.

         - **Auth local data source**: which has `HiveInterface` as dependency injection, and has the methods:

            - `cacheUser`: which takes as input the `client` | `ClientModel` stores the client infos in the local database.

            - `cacheDetails`: which takes as input `wilaya` | `String`, `commune` | `String` and `phoneNum` | `String` and stores the information locally.

            - `isAuth`: which verifies if the user is connected or not.

            - `deleteCache`: which cleans the local database.

            - `getChachedUser`: which gets the user stored locally.

            - `cacheName`: It takes a `name` | `String` as input and stores it in the local database.

            - `cachePhoneNumber`: It takes a `phoneNumber` | `String` as input and stores it in the local database.

            - `cacheEmail`: It takes a `email` | `String` as input stores it in the local database.

            - `editImage`: It takes a, `pictureUrl` | `String` as input stores it in the local database.


   3. **Presentation layer**:

      1 **Pages**:

         - **Login page**: This page is responsible for the login of the user.
         
         - **Sign up page**: This page is responsible for the registration of the user.
         
         - **Forgot password page**: This page is responsible for the password recovery of the user.
   
         - **One step to go page**: This page is responsible for the user to choose the language and address.
      
         - **Welcome page**: This page is the first page that the user sees when he opens the app.
   
         - **Artisan detail page**: This page is responsible of showing the detail informations of the artisan selected.

         - **Account settings page**: This page is responsible of editing the authenticated user profile information.

      2. **Controllers**: This represent the bridge between the UI and the backend, it directly connects with the usecases which in turn connect with the repositories.

         - **Details cubit**: This takes care of setting the system language and the additional information of the user (address and phone number).

         - **Forget password cubit**: This takes care of the forget password usecase.

         - **Log in cubit**: This takes care of the log in usecase.

         - **Profile info cubit**: This takes care of loading the profile infos of the user.

         - **Sign out cubit**: This takes care of the signing out usecase.

         - **Sign up cubit**: This takes care of the singing up usecase.

         - **Edit profile info**: This takes care of editing the profile information.


    
2. **Home feature**: This feature is responsible for displaying the pictures in the client app etc, basically the things that are not related to clients and companies.

   Following the clean architecture here are the layers of the app:

   1. **Domain layer**:

      1. **Entities**:

         - `CategoryEntity`: This is the entity responsible of the category of the companies. It contains these attributs:

            - `id`: This is the identifier of the category.

            - `name`: This is the name of the category.

      2. **Usecases**:

         - **Get pictures**: This use case is responsible for loading the pictures to display in the home page.

         - **Get categories**: This use case is responsible for loading the categories to display in the home page and in the search page.
         
      3. **Repositories**:
         
         - **Home repository**: It takes care of implementing the *get pictures* usecase.

         - **Categories repository**: It takes care of implementing the *get categories* usecase.
   
   2. **Data layer**:

      1. **Models**: 
      
         - `CategoryModel`: This is the model that interacts directly with the backend, it has these attributs:

            - `id`: This is the identifier of the category.

            - `name`: This is the name of the category.
      
      2. **Repositories**:

         - **Home repository implementation**: it is the implementation of the **Home repository** above.

         - **Categories repository implementation**: it is the implementation of the **Categories repository** above.
      
      3. **Datasources**:

         - **Home remote data source**: which `FirebaseFirestore` as dependency injection, and has this method:

            - `getPictures`: it returns the pictures stored in the database.

         - **Categories remote data source**: which `FirebaseFirestore` as dependency injection, and has this method:

            - `getCategories`: it returns the pictures stored in the database.

   3. **Presentation layer**:

      1. **Pages**:


         - **Home page**: which is the home page.

         - **Profile page**: which is the profile page of the user.

      2. **Controllers**: This represent the bridge between the UI and the backend, it directly connects with the usecases which in turn connect with the repositories.

         - **Pictures cubit**: This takes care of displaying the pictures stored in the remote database.
      

3. **Companies feature**: This feature is responsible of everthing related to companies in the app; loading the companies, looking for a company, rating a company etc.

   Following the clean architecture here are the layers of the app:

   1. **Domain layer**:

      1. **Entities**: There is no entities.

      2. **Usecases**:

         - **Get companies**: This use case is responsible for loading the companies.

         - **Get promoted companies**: This use case is responsible for loading the companies that are promoted by the admin.
         
      3. **Repositories**:
         
         - **Companies repository**: It takes care of implementing the usecases above.

   
   2. **Data layer**:

      1. **Models**: There is no models for this feature.
      
      2. **Repositories**:

         - **Companies repository implementation**: it is the implementation of the **Companies repository** above.

      3. **Datasources**:

         - **Companies remote data source**: which `FirebaseFirestore` as dependency injection, and has this method:

            - `getCompanies`: it returns the companies stored in the database.

            - `getPromotedCompanies`: it returns the promoted companies stored in the database.


   3. **Presentation layer**:

      1. **Pages**:

         - **Search page**: which is the page where the user can filter the companies in order to find what he want.

      2. **Controllers**: This represent the bridge between the UI and the backend, it directly connects with the usecases which in turn connect with the repositories.

         - **Categories cubit**: This cubit takes care of displayin the categories in the appropriate order and handles all operations related to the categories.

         - **Companies cubit**: This cubit is responsible of displaying the companies.
      
         - **Promoted companies cubit**: This cubit is responsible of displaying the promoted companies.


4. **Orders feature**: This feature is responsible of everthing related to ordering a company.

   Following the clean architecture here are the layers of the app:

   1. **Domain layer**:

      1. **Entities**:

         - `OrderEntity`: It is the entity responsible of the order, it has these attributes:
         
            - `id`: which is the identifier.
            
            - `companyId`: which is the identifier of the company the order is going to.

            - `companyName`: which is the name of the company.

            - `companyPhoneNumber`: which is the number of the company.

            - `companyServices`: which hold the services that the company provides.

            - `companyPictureUrl`: which hold the picture url of the company.

            - `clientId`: which is the id of the authenticated user.

            - `date`: which is the date of when was the order created.

      2. **Usecases**:

         - **Create order**: This use case is responsible for creating the order, it takes an order as input.

         - **Delete order**: This use case is responsible for deleting the order.

         - **Get orders**: This use case is responsible getting the orders.

         
      3. **Repositories**:
         
         - **Orders repository**: It takes care of implementing the usecases above.

   
   2. **Data layer**:

      1. **Models**:

         - `OrderModel`: It is the main model responsible of interacting with the backend.
      
      2. **Repositories**:

         - **Orders repository implementation**: it is the implementation of the **Orders repository** above.

      3. **Datasources**:

         - **Orders remote data source**: which `FirebaseFirestore` as dependency injection, and has this method:

            - `createOrder`: it takes an order as input and creates it in the backend.

            - `getOrders`: it sends a get request from the backend to get the orders.

            - `deleteOrder`: it deletes the order from the backend.


   3. **Presentation layer**:

      1. **Pages**:

            - **Company detail page**: which is the detail page of the company, it is here that the user can make an order.

            - **Orders page**: which is page responsible of loading the orders.


         2. **Controllers**: This represent the bridge between the UI and the backend, it directly connects with the usecases which in turn connect with the repositories.

            - **Order cubit**: This cubit takes care creating the orders.

            - **Orders cubit**: This cubit is responsible of displaying the orders and deleting them.
         

## 4. Packages used

   - `auto_route` [pub.dev](https://pub.dev/packages/auto_route): This is the main routing package used accross all the app.

   - `bloc` [pub.dev](https://pub.dev/packages/bloc) and `flutter_bloc` [pub.dev](https://pub.dev/packages/flutter_bloc): This is the main controller and state managment solution used in the app. 

   - `cloud_firestore` [pub.dev](https://pub.dev/packages/cloud_firestore), `firebase_core` [pub.dev](https://pub.dev/packages/firebase_core), `firebase_auth` [pub.dev](https://pub.dev/packages/firebase_auth) and `firebase_storage` [pub.dev](https://pub.dev/packages/firebase_storage): Those are the packages used to configure firebase and work with it inside the app.

   - `dartz` [pub.dev](https://pub.dev/packages/dartz): This package allows functional programing in Dart. 

   - `equatable` [pub.dev](https://pub.dev/packages/equatable): This package makes it easier to compare between objects.

   - `flutter_animate` [pub.dev](https://pub.dev/packages/flutter_animate): This allows UI animations.

   - `flutter_localizations` [pub.dev](https://pub.dev/packages/flutter_localizations): This allows multi languages.

   - `get_it` [pub.dev](https://pub.dev/packages/get_it): Which is the service locator used in the app to make sure every dependency injection is being fed.

   - `hive` [pub.dev](https://pub.dev/packages/hive) and `flutter_hive` [pub.dev](https://pub.dev/packages/flutter_hive): This is the package responsible for the local database of the app.

   - `iconsax` [pub.dev](https://pub.dev/packages/iconsax): A set of icons different from the default ones.

   - `internet_connection_checker` [pub.dev](https://pub.dev/packages/internet_connection_checker): A package to check if the device is connected to the Internet.

   - `intl` [pub.dev](https://pub.dev/packages/intl): Contains code to deal with internationalized/localized messages, date and number formatting and parsing, bi-directional text, and other internationalization issues.

   - `path_provider` [pub.dev](https://pub.dev/packages/path_provider): Plugin for getting commonly used locations on host platform file systems, such as the temp and app data directories.

   - `sizer` [pub.dev](https://pub.dev/packages/sizer): Responsive UI solution for Mobile App,Web and Desktop. Responsiveness made easy. 

   - `url_launcher` [pub.dev](https://pub.dev/packages/url_launcher): Flutter plugin for launching a URL. Supports web, phone, SMS, and email schemes.

   - `uuid` [pub.dev](https://pub.dev/packages/uuid): UUID generator and parser for Dart.

   - `cached_network_image` [pub.dev](https://pub.dev/packages/cached_network_image): Flutter library to load and cache network images. Can also be used with placeholder and error widgets.

   - `auto_size_text` [pub.dev](https://pub.dev/packages/auto_size_text): Flutter widget that automatically resizes text to fit perfectly within its bounds.

   - `smooth_page_indicator` [pub.dev](https://pub.dev/packages/smooth_page_indicator): Customizable animated page indicator with a set of built-in effects.
