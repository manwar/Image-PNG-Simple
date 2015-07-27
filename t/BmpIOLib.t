#include <stdio.h>
#include "BmpIoLib.h"

int main( int argc, char *argv[] )
{
	IBMP *pBmp;
	FILE *infile;
	int i, j;
	int w, h;

	if ( argc < 2 ) {
		printf( "���̓t�@�C�����w�肵�Ă��������B\n" );
		return -1;
	}

	// �t�@�C�����J��
	infile = fopen( argv[1], "rb" );
	if ( NULL == infile ) {
		printf( "�t�@�C�� %s ���J���܂���ł����B\n", argv[1] );
		return  -1;
	}

	// �ǂݍ���
	pBmp = BmpIO_Load( infile );
	fclose( infile );
	if ( NULL == pBmp ) {
		printf( "�t�@�C�� %s �̓ǂݍ��݂Ɏ��s���܂����B\n", argv[1] );
		return -1;
	}

	// ���ƍ������擾
	w = BmpIO_GetWidth( pBmp );
	h = BmpIO_GetHeight( pBmp );

	// �o��
	printf( "<html><body><table border=1 >\n" );
	for ( i = h - 1; i >= 0 ; i-- ){	// �㉺���t�ɂ��Ă��邱�Ƃɒ���
		printf( "<tr>\n" );
		for ( j = 0; j < w; j++ ) {
			// �P�܂����̃f�[�^���o��
			printf( "<td height=15 width=10 border=1 bgcolor=#%02X%02X%02X>&nbsp;</td>\n",
					BmpIO_GetR( j, i, pBmp ),
					BmpIO_GetG( j, i, pBmp ),
					BmpIO_GetB( j, i, pBmp ) );
		}
		printf( "</tr>\n" );
	}
	printf( "</table></body></html>\n" );

	// �r�b�g�}�b�v�̔j��
	BmpIO_DeleteBitmap( pBmp );
	return 0;
}