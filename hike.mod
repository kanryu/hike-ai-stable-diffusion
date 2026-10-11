module github.com/kanryu/hike-ai-stable-diffusion

hike 1.0

// The shared package activates the native stable-diffusion.cpp runtime.
package ./shared {
    target windows {
        link: "deps/stable-diffusion.cpp-master-948-228c707-windows/lib/stable-diffusion.lib"
        link: "deps/stable-diffusion.cpp-master-948-228c707-windows/lib/libwebp.lib"
        link: "deps/stable-diffusion.cpp-master-948-228c707-windows/lib/hike-adetail-bridge.lib"
        assets: "deps/stable-diffusion.cpp-master-948-228c707-windows/bin/*.dll"
    }
    target linux {
        link: "-lstable-diffusion"
    }
}

