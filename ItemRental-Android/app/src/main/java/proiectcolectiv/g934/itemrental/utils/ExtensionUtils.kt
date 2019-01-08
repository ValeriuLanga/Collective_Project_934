package proiectcolectiv.g934.itemrental.utils

import androidx.fragment.app.Fragment
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.LiveData
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProviders
import kotlin.reflect.KClass

fun <T : ViewModel> Fragment.getActivityViewModel(viewModelClass: KClass<T>) =
    activity?.let { ViewModelProviders.of(it).get(viewModelClass.java) }

fun <T> LiveData<T>.observe(owner: LifecycleOwner, action: (T?) -> Unit) {
    observe(owner, Observer { action(it) })
}

fun <T> LiveData<T>.observeNonNull(lifecycleOwner: LifecycleOwner, action: (T) -> Unit) =
    observe(lifecycleOwner, Observer { it?.let(action) })

fun <T1 : Any, T2 : Any, R : Any> multipleLet(p1: T1?, p2: T2?, block: (T1, T2) -> R?): R? =
    if (p1 != null && p2 != null) block(p1, p2) else null