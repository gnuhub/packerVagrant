Declare
v_sid NUMBER;
v_serial NUMBER;
Cursor c_Connections IS
Select sid, serial# From v$session where username='ENROLE';
Begin
OPEN c_Connections;
LOOP
FETCH c_Connections INTO v_sid, v_serial;
EXECUTE IMMEDIATE
'Alter SYSTEM KILL SESSION ''' || v_sid || ', ' || v_serial || ''' IMMEDIATE';
EXIT WHEN c_Connections%NOTFOUND;
END LOOP;
CLOSE c_Connections;
END;
/
