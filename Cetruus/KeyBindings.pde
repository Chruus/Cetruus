public class KeyBindings{
    LinkedList<Integer> inputBuffer;
    HashMap<String, Integer> keyBinds;
    int DAS, initialDAS;
    int defaultDAS, defaultInitialDAS;
    
    public KeyBindings() {
        defaultInitialDAS = initialDAS = file.loadInitDelay();
        defaultDAS = DAS = file.loadDelay();
        
        keyBinds = new HashMap<String, Integer>();
        inputBuffer = new LinkedList();
        
        if (!file.loadKeyBinds(keyBinds)) {
            reset();
            file.saveKeyBinds(keyBinds);
        }
    }
    
    public void setDAS(int newDAS) {
        defaultDAS = newDAS;
    }
    
    public  void setInitialDAS(int newInitialDAS) {
        defaultInitialDAS = newInitialDAS;
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
        initialDAS = defaultInitialDAS;
        DAS = defaultDAS;
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
    
    public  int DAS() {
        return defaultDAS;
    }
    
    public  int initialDAS() {
        return defaultInitialDAS;
    }
    
    public  boolean canRegisterKey() {
        if (inputBuffer.isEmpty())
            return false;
        
        if (initialDAS == defaultInitialDAS) {
            initialDAS = defaultInitialDAS;
            DAS = defaultDAS;
            initialDAS--;
            return true;
        }
        
        if (initialDAS > 0) {
            initialDAS--;
            return false;
        }
        if (initialDAS == 0) {
            initialDAS--;
            return true;
        }
        
        if (DAS > 0) {
            DAS--;
            return false;
        }
        
        DAS = defaultDAS;
        return true;
    }
}