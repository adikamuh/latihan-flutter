import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("dev") {
            dimension = "flavor-type"
            applicationId = "com.sumihai.hrms.dev"
            resValue(type = "string", name = "app_name", value = "STI Dev")
        }
        create("prod") {
            dimension = "flavor-type"
            applicationId = "com.sumihai.hrms"
            resValue(type = "string", name = "app_name", value = "STI")
        }
    }

    buildFeatures.resValues = true
}