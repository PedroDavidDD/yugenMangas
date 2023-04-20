package util;

import java.util.ArrayList;
import java.util.List;

public class DeString {

    public static Integer aInteger(String s) {
        Integer result = null;
        if (s != null) {
            try {
                result = Integer.valueOf(s);
            } catch (NumberFormatException e) {
            }
        }
        return result;
    }

    public static Double aDouble(String s) {
        Double result = null;
        if (s != null) {
            try {
                result = Double.valueOf(s);
            } catch (NumberFormatException e) {
            }
        }
        return result;
    }

    public static Float aFloat(String s) {
        Float result = null;
        if (s != null) {
            try {
                result = Float.valueOf(s);
            } catch (NumberFormatException e) {
            }
        }
        return result;
    }
    
    
    public static List<Integer> ids(String _ids) {
        List<Integer> list = new ArrayList<>();
        if (_ids != null) {
            String[] v_ids = _ids.split(",");
            for (String v_id : v_ids) {
                Integer id = aInteger(v_id);
                if (id != null) {
                    list.add(id);
                } else {
                    list = null;
                    break;
                }
            }
        }
        return list;
    }

    /*Listas*/
    public static Integer[] aIntegerL(String[] s) {
        Integer[] result = null;
        if ((s != null) && (s.length > 0)) {
            result = new Integer[s.length];
            for (int i = 0; i < result.length; i++) {
                try {
                    result[i] = Integer.valueOf(s[i]);
                } catch (NumberFormatException ex) {
                    result = null;
                    break;
                }
            }
        }
        return result;
    }

    public static Double[] aDoubleL(String[] s) {
        Double[] result = null;
        if ((s != null) && (s.length > 0)) {
            result = new Double[s.length];
            for (int i = 0; i < result.length; i++) {
                try {
                    result[i] = Double.valueOf(s[i]);
                } catch (NumberFormatException ex) {
                    result = null;
                    break;
                }
            }
        }
        return result;
    }
}
