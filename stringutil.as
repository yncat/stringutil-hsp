#ifndef __STRINGUTIL__
#define __STRINGUTIL__
#module string_util
#defcfunc stringutil_strlen str arg
string=arg
len=0
index=0
c=0
repeat
if index>=strlen(string):break
len++
c=peek(string,index)
if stringutil_checkIfAscii(c):index++:else:index+=2
loop
return len

#defcfunc stringutil_checkIfAscii int _charcode
if _charcode>=0x81:if _charcode<=0xfc:{
if _charcode<=0x9f or _charcode>=0xe0:return 0
}
return 1

#defcfunc stringutil_getAt str arg, int _index
string=arg
index=0
cursor=0
ret=""
c=0
repeat
if index>=strlen(string):cursor=-1:break
if cursor=_index:break
c=peek(string,index)
if stringutil_checkIfAscii(c): index++:else:index+=2
cursor++
loop
if cursor!-1:{
c=peek(string,index)
if stringutil_checkIfAscii(c): return strmid(string,index,1):else:return strmid(string,index,2)
}
return ""

#defcfunc stringutil_strmid str in, int start, int count
midstring=in
index=0
cursor=0
c=0
//スタート位置までスキップ
repeat
if index>=strlen(midstring):break
if cursor=start:break
c=peek(midstring,index)
if stringutil_checkIfAscii(c): index++:else:index+=2
cursor++
loop
if cursor=-1:return ""
//指定の文字数を取り出し
sdim ret,1024
ret_ptr=0
repeat
if index>=strlen(midstring):cursor=-1:break
if cursor=start+count:break
c=peek(midstring,index)
if stringutil_checkIfAscii(c): poke ret,ret_ptr,c:ret_ptr++:index++:else:wpoke ret,ret_ptr,wpeek(midstring,index):index+=2:ret_ptr+=2
cursor++
loop
return ret

#defcfunc stringutil_strip str in
string=in
firstpos=0
repeat
ch=stringutil_getAt(string,firstpos)
if ch=" " or ch="　": firstpos++:else:break
loop
endpos=stringutil_strlen(string)-1
repeat
ch=stringutil_getAt(string,endpos)
if ch=" " or ch="　": endpos--:else:endpos++:break
loop

if firstpos>=endpos:return ""
return stringutil_strmid(string,firstpos,endpos-firstpos)

#deffunc stringutil_splitByCharNum str _in, array _out, int _num, local _elems, local _len, local i
string=_in
_len=stringutil_strlen(string)
_elems=_len/_num
if _elems<=1:{
sdim _out,0
sdim _out,strlen(string)+1
_out=string
return
}
if _num*_elems<_len:_elems++
sdim _out,0
sdim _out,(2*len)+1,_elems
i=0
repeat _elems
_out(cnt)=stringutil_strmid(string,i,_num)
i+=_num
loop
return
#global

#endif