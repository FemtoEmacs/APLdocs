
%============================================================================
%                        C O N V E R T . P A S
%============================================================================

% This is a sample Turbo Pascal program for HeX-->Bin conversion useful
% for a safe download of pixel files (Turbo Pascal 3.0)

PROGRAM ASC_TO_BIN(Input,Output,Font_List_File);

        TYPE

        Byte          = 0..255;
        Name_Of_File  = String[20];


        VAR

        Newfile:File Of Byte;
        Textfile,Font_List_File:Text;
        First_Hex,Second_Hex,Ch:Char;
        One_Byte:Byte;
        I:Integer;
        Font_Name,File_Name,New_File_Name:Name_Of_File;


PROCEDURE Banner;

        Begin
            Writeln('!=================================================!');
            Writeln('! The text files to be converted must have been   !');
            Writeln('! originally obtained as follows: each byte is    !');
            Writeln('! replaced by two hexadecimals, the first of which!');
            Writeln('! is Byte Div 16 and the second Byte Mod 16. The  !');
            Writeln('! names of files are supposed to be found in a    !');
            Writeln('! separate list file.                             !');
            Writeln('!=================================================!');
        End;


FUNCTION Convert_Hex_To_Dec(X:Char):Integer;

        Begin
            If X In ['0'..'9'] Then Convert_Hex_To_Dec:=Ord(X)-48
            Else Convert_Hex_To_Dec:=Ord(X)-55;
        End;




PROCEDURE Convert_File(Var File_Name,New_File_Name:Name_Of_File);

VAR

A,B,I:Integer;


        Begin
            Assign(Textfile,File_Name);
            {$I-} Reset(Textfile) {$I+};
            If IOresult=0 Then
            Begin
                Assign(Newfile,New_File_Name);
                Rewrite(Newfile);
                While Not Eof(Textfile) Do
                Begin
                    While Not Eoln(Textfile) Do
                    Begin
                        Read(Textfile,First_Hex);
                        Read(Textfile,Second_Hex);
                        A:=Convert_Hex_To_Dec(First_Hex);
                        B:=Convert_Hex_To_Dec(Second_Hex);
                        One_Byte:=(16*A)+B;
                        If Eoln(Textfile) Then Readln(Textfile);
                        Write(Newfile,One_Byte);
                    End;
                End;
                For I:=0 To 30-Length(New_File_Name) Do Write('.');
                Writeln(New_File_Name,' written');
                Close(Textfile);
                Close(Newfile);
            End Else
            Writeln('This File Not Found!');
         End;

                                           (***  M A I N   P R O G R A M  ***)
BEGIN

    Banner;
    Writeln;
    Writeln('Give The Name Of File Containing The List Of Pxl Files: ');
    Readln(File_Name);
    Assign(Font_List_File,File_Name);
    {$I-} Reset(Font_List_File) {$I+};
    If IOresult=0 Then
    Begin
        Writeln;
        Writeln('... started converting ...');
        Writeln;
        While Not Eof(Font_List_File) Do
        Begin
            Font_Name:='';
            While Not Eoln(Font_List_File) Do
            Begin
                Read(Font_List_File,Ch);
                Font_Name:=Font_Name+Ch;
            End;
            Write(Font_Name);
            New_File_Name:=Copy(Font_Name,1,Pos('.',Font_Name)-1)+'.bxl';
            Readln(Font_List_File);
            Convert_File(Font_Name,New_File_Name);
        End;
        Writeln;
        Writeln('... conversion done ...');
    End Else
    Writeln('File List Not Found!');
END.
