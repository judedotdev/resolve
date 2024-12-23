# Keep annotations used by Tink and Error Prone
-keep class javax.annotation.** { *; }
-keep class com.google.errorprone.annotations.** { *; }
-keep class javax.lang.model.element.Modifier { *; }

# Suppress warnings about missing classes
-dontwarn javax.annotation.Nullable
-dontwarn javax.annotation.concurrent.GuardedBy
-dontwarn javax.lang.model.element.Modifier
