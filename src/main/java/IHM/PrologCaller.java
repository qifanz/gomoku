package IHM;

import org.jpl7.*;

import java.io.*;
import java.lang.Integer;
import java.util.HashMap;
import java.util.Map;
import Exception.GomokuFinishedException;

import javax.swing.*;

public class PrologCaller {

    private int turn = 1;
    final String QueryAppend ="assert(board(Board)),init(X).";
    private Query[] initQuery;
    private Writer writer;

    public PrologCaller(String path,String iaFileName) throws FileNotFoundException, UnsupportedEncodingException {
        Term[] consult_arg1 = {new Atom(path+"\\"+iaFileName)};
        Term[] consult_arg2 = {new Atom(path+"\\detectWin.pl")};
        Term[] consult_arg3 = {new Atom(path+"\\evaluateFunction.pl")};
        Term[] consult_arg4 = {new Atom(path+"\\minmax")};
        Term[] consult_arg5 = {new Atom(path+"\\utils.pl")};
        Term[] consult_arg6 = {new Atom(path+"\\generator.pl")};
        initQuery = new Query[]{new Query("consult",consult_arg1),new Query("consult",consult_arg2),
                new Query("consult",consult_arg3),new Query("consult",consult_arg4),
                new Query("consult",consult_arg5),new Query("consult",consult_arg6),};
        writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(path+"\\data.csv"),"UTF-8"));
    }

    public int getNextMove(HashMap<Integer,Boolean> liste) throws GomokuFinishedException {
        //init variables
        StringBuilder builder = new StringBuilder();
        renew();
        //start of calculators
        for(HashMap.Entry<Integer,Boolean> item : liste.entrySet()){
            if(item.getValue()){
                builder.append(Nth0(item.getKey(),"N"));
            }else if (!item.getValue()){
                builder.append(Nth0(item.getKey(),"B"));
            }
        }
        builder.append(QueryAppend);
        Query q = new Query(builder.toString());
        long start = System.nanoTime();
        Map[] r = q.allSolutions();
        long turnTime = System.nanoTime() - start;
        System.out.println("Turn "+ turn +" time : "+turnTime/1000000000.0);
        try {
            writer.write((turn++)+";"+turnTime/1000000000.0+"\r\n");
            writer.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return Integer.parseInt(r[r.length-1].get("X").toString());
    }

    private String Nth0(int pos, String color){
        return "nth0("+pos+",Board,"+"'"+color+"'"+"),";
    }

    private void renew(){
        JPL.init();
        for (Query q:initQuery) {
            q.open();
            q.getSolution();
            q.close();
        }
    }

}
