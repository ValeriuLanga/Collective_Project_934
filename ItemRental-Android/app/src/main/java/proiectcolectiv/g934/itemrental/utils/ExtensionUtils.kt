package proiectcolectiv.g934.itemrental.utils

import android.util.Patterns
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentActivity
import androidx.lifecycle.*
import kotlin.reflect.KClass

fun <T : ViewModel> Fragment.getActivityViewModel(viewModelClass: KClass<T>) =
        activity?.let { ViewModelProviders.of(it).get(viewModelClass.java) }

fun <T> LiveData<T>.observeNonNull(lifecycleOwner: LifecycleOwner, action: (T) -> Unit) =
        observe(lifecycleOwner, Observer { it?.let(action) })

fun <T1 : Any, T2 : Any, R : Any> multipleLet(p1: T1?, p2: T2?, block: (T1, T2) -> R?): R? =
        if (p1 != null && p2 != null) block(p1, p2) else null

fun FragmentActivity.showToast(text: String) = Toast.makeText(this, text, Toast.LENGTH_SHORT).show()

fun String.isValidEmail(): Boolean = this.isNotEmpty() && Patterns.EMAIL_ADDRESS.matcher(this).matches()