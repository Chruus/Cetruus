public class KeyBindings{
    LinkedList<Integer> inputBuffer;
    HashMap<String, Integer> keyBinds;
    int keyDelay, initialKeyDelay;
    int defaultKeyDelay, defaultInitialKeyDelay;
    
    public KeyBindings() {
        defaultInitialKeyDelay = initialKeyDelay = file.loadInitDelay();
        defaultKeyDelay = keyDelay = file.loadDelay();
        
        keyBinds = new HashMap<String, Integer>();
        inputBuffer = new LinkedList();
        
        if (!file.loadKeyBinds(keyBinds)) {
            reset();
            file.saveKeyBinds(keyBinds);
        }
    }
    
    public void setKeyDelay(int newKeyDelay) {
        defaultKeyDelay = newKeyDelay;
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
    
    public void set(String keyBind, int key) {
        keyBinds.put(keyBind, key);
        file.saveKeyBinds(keyBinds);
    }
    
    public void keyPressed(int key) {
        if (inputBuffer.contains(key))
            return;
        
        inputBuffer.push(key);
        initialKeyDelay = defaultInitialKeyDelay;
        keyDelay = defaultKeyDelay;
    }
    
    public  void keyReleased(int key) {
        if (inputBuffer.contains(key))
            inputBuffer.remove(new Integer(key));
    }
    
    public  int getCurrentKey() {
        if (!inputBuffer.isEmpty())
            return inputBuffer.peek();
        return - 1;
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
        if (inputBuffer.isEmpty())
            return false;
        
        if (initialKeyDelay == defaultInitialKeyDelay) {
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