package proiectcolectiv.g934.itemrental.page.splash

import android.os.Bundle
import android.os.Handler
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.core.view.ViewCompat
import androidx.navigation.fragment.FragmentNavigatorExtras
import androidx.navigation.fragment.NavHostFragment
import dagger.android.support.DaggerFragment
import kotlinx.android.synthetic.main.fragment_splash.*
import proiectcolectiv.g934.itemrental.R
import proiectcolectiv.g934.itemrental.data.local.prefs.AppPrefsConstants
import proiectcolectiv.g934.itemrental.data.local.prefs.StringPreference
import javax.inject.Inject
import javax.inject.Named

class SplashFragment : DaggerFragment() {

    @field:[Inject Named(AppPrefsConstants.USER_PREF)]
    lateinit var userPref: StringPreference

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        return inflater.inflate(R.layout.fragment_splash, container, false)
    }

    override fun onResume() {
        super.onResume()
        handleApplicationStartup()
    }

    private fun handleApplicationStartup() = Handler().postDelayed({
        if (userPref.isSet()) {
            NavHostFragment.findNavController(this)
                    .navigate(R.id.action_splashFragment_to_listFragment)
        } else {
            val extras = FragmentNavigatorExtras(splashImage to ViewCompat.getTransitionName(splashImage)!!)
            NavHostFragment.findNavController(this)
                    .navigate(R.id.action_splashFragment_to_loginFragment, null, null, extras)
        }
    }, 1000)
}