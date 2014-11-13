#include <stdio.h>
#include <time.h>
#include <string.h>

static char buffer[8192];
static char hdr[96];
static FILE *file, *data;

int main(int argc, char **argv)
{
  char ch, *p;  int sequence, cnt;  time_t crt;  size_t i, bytes;
  if (argc < 4) {
    printf("Usage: orpcap <hostname> <sequence> <count>\n");
    return 0;
  }
  sequence = atoi(argv[2]);  cnt = atoi(argv[3]);
  if ((sequence <= 0) || (cnt <= 0)) {
    printf("Bad sequence or count\n");
    return -1;
  }
  // build ORH
  memset(hdr, 0, sizeof(hdr));
  hdr[0] = 'O';  hdr[1] = 'R';  hdr[2] = 'H';
  p = hdr + 4;
  strcpy(p, argv[1]);  p += 33;
  sprintf(p, "%010d", sequence);  p += 11;
  sprintf(p, "%010d", sequence + cnt - 1);  p += 11;
  crt = time(NULL);
  sprintf(p, "%010d", time - 30);  p += 11;
  sprintf(p, "%010d", time);  p += 11;
  sprintf(p, "%010d\n", cnt);
  // calculate checksum for header
  ch = 0;  for (i = 0; i < 92; i++) ch ^= hdr[i];
  // write header to file
  file = fopen("tmp", "wb");
  fwrite(hdr, 1, 92, file);
  // read content
  if (argc > 4) {
    data = fopen(argv[4], "rb");
    if (data) {
      while(1) {
        bytes = fread(buffer, 1, 8192, data);  if (bytes <= 0) break;
        fwrite(buffer, 1, bytes, file);
        for (i = 0; i < bytes; i++) ch ^= buffer[i];
      }
      fclose(data);
    }
  }
  // rewrite header
  hdr[3] = ch;
  fseek(file, 0, SEEK_SET);
  fwrite(hdr, 1, 92, file);
  fclose(file);
  return 0;
}

