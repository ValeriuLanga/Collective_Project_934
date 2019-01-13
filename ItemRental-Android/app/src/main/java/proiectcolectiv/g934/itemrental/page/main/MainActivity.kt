package proiectcolectiv.g934.itemrental.page.main

import android.os.Bundle
import proiectcolectiv.g934.itemrental.R
import proiectcolectiv.g934.itemrental.base.BaseActivity

class MainActivity : BaseActivity<MainViewModel, MainViewModelFactory>() {

    override fun getViewModelClass() = MainViewModel::class.java

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }
}
