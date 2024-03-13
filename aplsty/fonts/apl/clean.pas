
%============================================================================
%                            C L E A N . P A S
%============================================================================

% A sample Turbo Pascal (3.0) program for truncating downloaded pixel files
% to the standard size assumed by some TeX-oriented programs (starting from
% a file of type: File of Array[0..511] of Byte.

Program Clean_Up(Output,Input,Font_List_File);

LABEL

Report;


TYPE

Name_Of_File  =String[20];
Name_Of_Font  =String[20];
Byte          =0..255;
Byte_Block    =Array[0..511] Of Byte;
Word          =Array[0..3] Of Byte;



VAR

Font_List_File:Text;
Pxl_File:File of Byte_Block;
Block:Byte_Block;
Last_Blocks:Array[0..1023] Of Byte;
One_Word:Word;
File_Name,New_File_Name:Name_Of_File;
Font_Name:Name_Of_Font;
New_Pxl_File:File Of Word;
File_Id_Found,Bad_Pxl_File:Boolean;
End_Of_Block:Boolean;
IOR,Word_Pos:Integer;
Ch:Char;
Word_Value:Real;


PROCEDURE Banner;

    Begin
        Writeln('!==================================================!');
        Writeln('! The files to be repaired are assumed consist of  !');
        Writeln('! blocks 512 bytes long. The repaired files consist!');
        Writeln('! of words. The names of files are supposed to be  !');
        Writeln('! found from a separate file.                      !');
        Writeln('!==================================================!');
    End;



PROCEDURE Initialize;

    Begin
        File_Id_Found:=False;
        Word_Pos:=0;
        End_Of_Block:=False;
        Bad_Pxl_File:=False;
    End;




PROCEDURE Check_File_Id;

VAR

A:Integer;

      Begin
          If Abs(Word_Value)<2000.0 Then
          Begin
          A:=Round(Word_Value);
          If (A=1001) Or (A=1002) Then File_Id_Found:=True;
          End;
      End;



PROCEDURE READ_NEXT_WORD;

VAR

I:Integer;

    Begin
        If Not End_Of_Block Then
        Begin
            For I:=0 To 3 Do One_Word[3-I]:=Last_Blocks[1023-((4*Word_Pos)+I)];
            Word_Pos:=Word_Pos+1;
            If Word_Pos>255 Then End_Of_Block:=True;
        End;
    End;




PROCEDURE EVALUATE_NEXT_WORD;

    Begin
        Read_Next_Word;
        Word_Value:=One_Word[3]+256.0*(One_Word[2]+
                              256.0*(One_Word[1]+256.0*One_Word[0]));

    End;



PROCEDURE Find_File_Id;

Var

K:Integer;

    Begin
        While (Not File_Id_Found) And (Not End_Of_Block) Do
        Begin
            Evaluate_Next_Word;
            Check_File_Id;
        End;
        If Not File_Id_Found Then
        Begin
            For K:=Length(Font_Name) To 30 Do Write('.');
            Writeln(' Bad Pxl File, File Not Repaired');
            Bad_Pxl_File:=True;
        End;
    End;



PROCEDURE Rewrite_Pxl_File(Var Font_Name,File_Name:Name_Of_File);

LABEL

Report;

VAR

I,J,K,IOR:Integer;

    Begin
        Assign(Pxl_File,Font_Name);
        {$I-} Reset(Pxl_File) {$I+};
        IOR:=IOresult;
        If IOR<>0 Then Goto Report;
        Assign(New_Pxl_File,File_Name);
        Rewrite(New_Pxl_File);
        Seek(Pxl_File,0);
        For I:=0 To Filesize(Pxl_File)-3 Do
        Begin
            Read(Pxl_File,Block);
            For J:=0 To 127 Do
            Begin
                For K:=0 To 3 Do One_Word[K]:=Block[(4*J)+K];
                Write(New_Pxl_File,One_Word);
            End;
        End;
        Read(Pxl_File,Block);
        For I:=0 To 511 Do
        Last_Blocks[I]:=Block[I];
        Read(Pxl_File,Block);
        For I:=512 To 1023 Do
        Last_Blocks[I]:=Block[I-512];
        Find_File_ID;
        Word_Pos:=255-Word_Pos;
        If Not Bad_Pxl_File Then
        Begin
            For I:=0 To Word_Pos+1 Do
            Begin
                For K:=0 To 3 Do One_Word[K]:=Last_Blocks[(4*I)+K];
                Write(New_Pxl_File,One_Word);
            End;
            Report:Begin
                       For I:=0 To 30-Length(Font_Name) Do Write('.');
                       If IOR<>0 Then Writeln('File Not Found') Else
                       Begin
                           Writeln(New_File_Name);
                           Close(New_Pxl_File);
                           Close(Pxl_File);
                       End;
                   End;
        End;
    End;




                                          (***  M A I N   P R O G R A M  ***)
BEGIN

    Banner;
    Writeln;
    Writeln('Give The Name Of File Containing The List Of Pxl Files: ');
    Readln(File_Name);
    Assign(Font_List_File,File_Name);
    {$I-} Reset(Font_List_File) {$I+};
    IOR:=IOresult;
    If IOR<>0 Then Goto Report;
    While Not Eof(Font_List_File) Do
    Begin
        Initialize;
        Font_Name:='';
        While Not Eoln(Font_List_File) Do
        Begin
            Read(Font_List_File,Ch);
            Font_Name:=Font_Name+Ch;
        End;
        Readln(Font_List_File);
        Write(Font_Name);
        New_File_Name:=Copy(Font_Name,1,Pos('.',Font_Name)-1)+'.rxl';
        Rewrite_Pxl_File(Font_Name,New_File_Name);
     End;
     Writeln;
     Report: Begin
                 If IOR<>0 Then Writeln('File Not Found!') Else
                 Begin
                     Writeln('............Done!...........');
                     Close(Font_List_File);
                 End;
             End;
END.
