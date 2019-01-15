package proiectcolectiv.g934.itemrental.page.login

import android.os.Bundle
import proiectcolectiv.g934.itemrental.R
import proiectcolectiv.g934.itemrental.base.BaseActivity

class LoginActivity : BaseActivity<LoginViewModel, LoginViewModelFactory>() {

    override fun getViewModelClass() = LoginViewModel::class.java

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.fragment_login)
    }
}