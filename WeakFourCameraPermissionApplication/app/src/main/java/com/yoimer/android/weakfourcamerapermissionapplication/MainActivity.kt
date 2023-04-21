package com.yoimer.android.weakfourcamerapermissionapplication

import android.content.pm.PackageManager
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Toast
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.yoimer.android.weakfourcamerapermissionapplication.databinding.ActivityMainBinding

const val CAMERA_REQUEST_CODE = 0
class MainActivity : AppCompatActivity() {
    private lateinit var binding: ActivityMainBinding
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        binding.btCamera.setOnClickListener {
            checkCameraPermission()
        }
    }


    private fun showToast(stringId: Int, time: Int) {
        Toast.makeText(this, stringId, time).show()
    }

    private fun showShortToast(stringId: Int) {
        showToast(stringId, Toast.LENGTH_SHORT)
    }

    private fun checkCameraPermission() {
        if(ContextCompat.checkSelfPermission(this, android.Manifest.permission.CAMERA) != PackageManager.PERMISSION_GRANTED)
            requestCameraPermission()
        else showShortToast(R.string.already_camera_permission)
    }

    private fun requestCameraPermission() {
        if(ActivityCompat.shouldShowRequestPermissionRationale(this, android.Manifest.permission.CAMERA))
            showShortToast(R.string.already_rejected_camera_permission)
        else {
            showShortToast(R.string.accept_camera_permission)
            ActivityCompat.requestPermissions(this, arrayOf(android.Manifest.permission.CAMERA), CAMERA_REQUEST_CODE)
        }
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        when(requestCode) {
            CAMERA_REQUEST_CODE -> {
                if(grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED)
                    showShortToast(R.string.accepted_camera_permission)
                else showShortToast(R.string.rejected_camera_permission)
            }
        }
    }
}