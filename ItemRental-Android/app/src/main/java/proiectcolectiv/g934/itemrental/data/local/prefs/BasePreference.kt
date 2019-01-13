package proiectcolectiv.g934.itemrental.data.local.prefs

import android.content.SharedPreferences

abstract class BasePreference<T>(
    val preferences: SharedPreferences,
    val key: String,
    val defaultValue: T?
) {
    constructor(preferences: SharedPreferences, key: String) : this(preferences, key, null)

    abstract fun get(): T

    abstract fun set(value: T?)

    fun isSet(): Boolean = preferences.contains(key)

    fun delete() {
        preferences.edit().remove(key).apply()
    }

}