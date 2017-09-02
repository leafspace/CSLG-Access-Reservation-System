package cn.cslg.ReservationVerify.Thread;

import com.pi4j.io.gpio.PinState;
import com.pi4j.io.gpio.event.GpioPinListenerDigital;
import com.pi4j.io.gpio.event.GpioPinDigitalStateChangeEvent;

public class ButtonListenThread implements GpioPinListenerDigital {
    public boolean open;

    public ButtonListenThread() {
        this.open = false;
    }

    @Override
    public void handleGpioPinDigitalStateChangeEvent(GpioPinDigitalStateChangeEvent event) {
        if (event.getState() == PinState.HIGH) {
            this.open = true;
        }
    }
}