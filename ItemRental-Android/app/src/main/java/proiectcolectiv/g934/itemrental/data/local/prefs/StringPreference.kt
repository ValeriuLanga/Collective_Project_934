package proiectcolectiv.g934.itemrental.data.local.prefs

import android.content.SharedPreferences
import android.text.TextUtils

class StringPreference(preferences: SharedPreferences, key: String) : BasePreference<String>(preferences, key) {

    override fun get(): String = preferences.getString(key, defaultValue) ?: ""

    override fun set(value: String?) {
        if (TextUtils.isEmpty(value)) {
            delete()
        } else {
            preferences.edit().putString(key, value).apply()
        }
    }
}