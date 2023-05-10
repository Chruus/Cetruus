public class KeyBindings{
    HashMap<String, Integer> keyBinds;
    
    public KeyBindings() {
        keyBinds = new HashMap<String, Integer>();
        reset();
    }
    
    public void reset() {
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
    }
    
    public int get(String keyBind) {
        return keyBinds.get(keyBind);
    }
}