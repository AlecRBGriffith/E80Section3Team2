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
    DESIRED = 14*10*MEG
    FUDGE = 1*KIL
    copypart('F:\\flightOneTrimmed.dat','F:\\flightOneTrimmedExperiment.dat',14*50*MEG,DESIRED+FUDGE)
    print('Finished')
