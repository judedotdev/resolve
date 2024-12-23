# Keep annotations used by Tink and Error Prone
-keep class javax.annotation.** { *; }
-keep class com.google.errorprone.annotations.** { *; }
-keep class javax.lang.model.element.Modifier { *; }
-keep class com.example.resolve_app.network.** { *; }
-keep class com.example.resolve_app.models.** { *; }
-keep class com.example.resolve_app.** { *; }

# Keep classes used by the Dart HTTP package
-keep class io.flutter.plugin.common.** { *; }
-keep class io.flutter.embedding.engine.** { *; }
-keep class io.flutter.** { *; }

# Suppress warnings about missing classes
-dontwarn javax.annotation.Nullable
-dontwarn javax.annotation.concurrent.GuardedBy
-dontwarn javax.lang.model.element.Modifier

# Keep Google Play Core classes related to Split Install
-keep class com.google.android.play.core.splitcompat.** { *; }
-keep class com.google.android.play.core.splitinstall.** { *; }
-keep class com.google.android.play.core.tasks.** { *; }

# Keep Flutter-related classes for PlayStore deferred components
-keep class io.flutter.embedding.engine.deferredcomponents.** { *; }

# Suppress warnings for missing Google Play Core classes
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.SplitInstallException
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManager
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManagerFactory
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest$Builder
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest
-dontwarn com.google.android.play.core.splitinstall.SplitInstallSessionState
-dontwarn com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task
