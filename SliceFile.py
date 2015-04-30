def copypart(src,dest,start,length,bufsize=1024*1024):
    with open(src,'rb') as f1:
        f1.seek(start)
        with open(dest,'wb') as f2:
            while length:
                chunk = min(bufsize,length)
                data = f1.read(chunk)
                f2.write(data)
                length -= chunk

if __name__ == '__main__':
    KIL = 2**10
    MEG = 2**20
    GIG = 2**30
    DESIRED = 15*10*MEG
    FUDGE = 1*KIL
    i = 0
    while i*DESIRED <= 1500*MEG:
        copypart('thermotronData.dat','thermotronDataSlice' + str(i) +'.DAT',i*DESIRED,DESIRED)
        i += 1
        
    print('Finished')
