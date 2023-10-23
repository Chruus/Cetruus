public class KeyBindings{
    ArrayList<Integer> keyCodes;
    boolean isKeyPressed;
    HashMap<String, Integer> keyBinds;
    int keyDelay, initialKeyDelay;
    int defaultKeyDelay, defaultInitialKeyDelay;
    int lastKeyCode;
    
    public KeyBindings() {
        defaultInitialKeyDelay = initialKeyDelay = 12;
        defaultKeyDelay = keyDelay = 1;
        
        keyBinds = new HashMap<String, Integer>();
        keyCodes = new ArrayList<Integer>();
        
        reset();
        //  loadKeyBinds();        
    }
    
    public void setKeyDelay(int newKeyDelay) {
        defaultKeyDelay = newKeyDelay;
    }
    
    public void loadKeyBinds() {
        //file.saveKeyBinds(keyBinds);
    }
    
    public  void setInitialKeyDelay(int newInitialKeyDelay) {
        defaultInitialKeyDelay = newInitialKeyDelay;
    }
    
    public  void reset() {
        keyBinds.put("move left", LEFT);
        keyBinds.put("move right", RIGHT);
        keyBinds.put("soft drop", DOWN);
        keyBinds.put("rotate right", UP);
        keyBinds.put("rotate left",(int)'Z');
        keyBinds.put("hard drop",(int)' ');
        keyBinds.put("hold tetro",(int)'C');
    }
    
    public  void set(String keyBind, int key) {
        keyBinds.put(keyBind, key);
    }
    
    public  void keyPressed() {
        isKeyPressed = true;
        if (!keyCodes.contains(keyCode))
            keyCodes.add(keyCode);
        
        initialKeyDelay = defaultInitialKeyDelay;
        keyDelay = defaultKeyDelay;
    }
    
    public  void keyReleased() {
        if (keyCodes.size() > 0)
            keyCodes.remove(0);
        
        if (keyCodes.size() == 0) {
            lastKeyCode = -1;
            keyPressed = false;
        }
    }
    
    public  int getCurrentKey() {
        return keyCodes.get(0);
    }
    
    public  int get(String keyBind) {
        return keyBinds.get(keyBind);
    }
    
    public  int keyDelay() {
        return defaultKeyDelay;
    }
    
    public  int initialKeyDelay() {
        return defaultInitialKeyDelay;
    }
    
    public  boolean canRegisterKey() {
        if (keyCodes.size() == 0 || keyPressed == false)
            return false;
        
        if (initialKeyDelay == defaultInitialKeyDelay || keyCodes.get(0) != lastKeyCode) {
            lastKeyCode = keyCodes.get(0);
            initialKeyDelay = defaultInitialKeyDelay;
            keyDelay = defaultKeyDelay;
            initialKeyDelay--;
            return true;
        }
        
        if (initialKeyDelay > 0) {
            initialKeyDelay--;
            return false;
        }
        if (initialKeyDelay == 0) {
            initialKeyDelay--;
            return true;
        }
        
        if (keyDelay > 0) {
            keyDelay--;
            return false;
        }
        
        keyDelay = defaultKeyDelay;
        return true;
    }
}