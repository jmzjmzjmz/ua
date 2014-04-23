#!/usr/bin/env python  

import sys
import socket
import time

PIXEL_SIZE = 3
# gamma = bytearray(256)

gamma = [
      0, 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  2,  2,  2,  2,  2,  2,
      2,  3,  3,  3,  3,  3,  4,  4,  4,  4,  4,  5,  5,  5,  5,  6,
      6,  6,  6,  7,  7,  7,  8,  8,  8,  8,  9,  9,  9, 10, 10, 11,
     11, 11, 12, 12, 13, 13, 13, 14, 14, 15, 15, 16, 16, 17, 17, 18,
     18, 19, 19, 20, 20, 21, 21, 22, 23, 23, 24, 24, 25, 26, 26, 27,
     28, 28, 29, 30, 30, 31, 32, 32, 33, 34, 35, 36, 36, 37, 38, 39,
     40, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 49, 50, 51, 52, 53,
     54, 55, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 68, 69, 70, 71,
     72, 74, 75, 76, 77, 79, 80, 81, 83, 84, 85, 87, 88, 89, 91, 92,
     94, 95, 97, 98, 99,101,103,104,106,107,109,110,112,113,115,117,
    118,120,122,123,125,127,129,130,132,134,136,138,139,141,143,145,
    147,149,151,153,155,157,159,161,163,165,167,169,171,173,175,177,
    179,182,184,186,188,190,193,195,197,200,202,204,207,209,211,214,
    216,219,221,223,226,228,231,234,236,239,241,244,247,249,252,255]


UDP_IP = "192.168.2.11"
# UDP_IP = "beaglebone.local"
UDP_PORT = 9999


sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM) # UDP

sockCOMP = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sockCOMP.bind((UDP_IP, UDP_PORT))

print "UDP target IP:", UDP_IP
print "UDP target port:", UDP_PORT

spidev = file("/dev/spidev0.0", "wb") 


def correct_pixel_brightness(pixel):
    corrected_pixel = bytearray(3)
    corrected_pixel[0] = int(pixel[0] / 1.1)
    corrected_pixel[1] = int(pixel[1] / 1.1)
    corrected_pixel[2] = int(pixel[2] / 1.3)

    return corrected_pixel

def filter_pixel(input_pixel, brightness):
	output_pixel = bytearray(PIXEL_SIZE)
	input_pixel[0] = int(brightness * input_pixel[0])
	input_pixel[1] = int(brightness * input_pixel[1])
	input_pixel[2] = int(brightness * input_pixel[2])
	output_pixel[0] = gamma[input_pixel[0]]
	output_pixel[1] = gamma[input_pixel[1]]
	output_pixel[2] = gamma[input_pixel[2]]
	return output_pixel



while True:
	data, addr = sockCOMP.recvfrom(1024)  # blocking call


	pixels_in_buffer = len(data) / PIXEL_SIZE
	# print pixels_in_buffer
	pixels = bytearray(pixels_in_buffer * PIXEL_SIZE)

	# Apply Gamma
	for pixel_index in range(pixels_in_buffer):
		pixel_to_adjust = bytearray(data[(pixel_index * PIXEL_SIZE):((pixel_index * PIXEL_SIZE) + PIXEL_SIZE)])
		pixel_to_filter = correct_pixel_brightness(pixel_to_adjust)
		pixels[((pixel_index) * PIXEL_SIZE):] = filter_pixel(pixel_to_filter[:], 1)
	
	# print pixels
	spidev.write(pixels)
	spidev.flush()  
