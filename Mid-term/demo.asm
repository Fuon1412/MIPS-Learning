.data
words_0_19: .asciiz "khong mot hai ba bon nam sau bay tam chin muoi muoi mot muoi hai muoi ba muoi bon muoi lam muoi sau muoi bay muoi tam muoi chin"
words_20_90: .asciiz "hai muoi ba muoi bon muoi nam muoi sau muoi bay muoi tam muoi chin"
words_0_9: .asciiz "mot hai ba bon lam sau bay tam chin"
hundred: .asciiz "tram "
million: .asciiz "trieu "
thousand: .asciiz "nghin "
zero: .asciiz "khong"
.text
.globl num_to_text1
.globl num_to_text

main:
    li $v0, 5               # syscall 5 (nhập số nguyên)
    syscall
    move $a0, $v0           # $a0 = num
    jal num_to_text         # Gọi hàm num_to_text với tham số num
    li $v0, 10              # syscall 10 (kết thúc chương trình)
    syscall
num_to_text1:
    # Lấy các giá trị hàng trăm, hàng chục, hàng đơn vị
    div $a0, $zero, 100      # $a0 = num / 100 (hàng trăm)
    mfhi $t0                # $t0 = num % 100
    div $t0, $zero, 10       # $t1 = (num % 100) / 10 (hàng chục)
    mfhi $t1                 # $t1 = (num % 100) % 10 (hàng đơn vị)

    # In ra từng phần của số thành văn bản
    bnez $a0, print_hang_tram   # Nếu hàng trăm khác 0, in hàng trăm
    bnez $t0, print_hang_chuc   # Nếu hàng chục khác 0, in hàng chục
    bnez $t1, print_hang_don_vi # Nếu hàng đơn vị khác 0, in hàng đơn vị
    j end_num_to_text1

print_hang_tram:
    # In hàng trăm
    sll $t2, $a0, 2          # $t2 = hàng trăm * 4 (sử dụng như index)
    la $t3, words_0_19       # Địa chỉ của mảng words_0_19
    add $t3, $t3, $t2        # $t3 = &words_0_19 + (hàng trăm * 4)
    lw $a0, 0($t3)           # $a0 = words_0_19[hàng trăm]
    li $v0, 4                # syscall 4 (in chuỗi)
    syscall
    li $v0, 4                # syscall 4 (in chuỗi)
    la $a0, 32               # $a0 = ' ' (khoảng trắng)
    syscall
    j print_hang_chuc

print_hang_chuc:
    # In hàng chục
    bgtz $t0, print_hang_chuc_muoi # Nếu hàng chục > 0, in hàng chục muoi
    j print_hang_don_vi            # Ngược lại, in hàng đơn vị

print_hang_chuc_muoi:
    li $t2, 20                # $t2 = 20
    add $t2, $t2, $t0         # $t2 = 20 + hàng chục
    sll $t2, $t2, 2           # $t2 = ($t2 * 4) (sử dụng như index)
    la $t3, words_0_19        # Địa chỉ của mảng words_0_19
    add $t3, $t3, $t2         # $t3 = &words_0_19 + ($t2 * 4)
    lw $a0, 0($t3)            # $a0 = words_0_19[20 + hàng chục]
    li $v0, 4                 # syscall 4 (in chuỗi)
    syscall
    li $v0, 4                 # syscall 4 (in chuỗi)
    la $a0, 32                # $a0 = ' ' (khoảng trắng)
    syscall
    bnez $t1, print_hang_don_vi # Nếu hàng đơn vị khác 0, in hàng đơn vị
    j end_num_to_text1

print_hang_don_vi:
    # In hàng đơn vị
    sll $t2, $t1, 2          # $t2 = hàng đơn vị * 4 (sử dụng như index)
    la $t3, words_0_9        # Địa chỉ của mảng words_0_9
    add $t3, $t3, $t2        # $t3 = &words_0_9 + (hàng đơn vị * 4)
    lw $a0, 0($t3)           # $a0 = words_0_9[hàng đơn vị]
    li $v0, 4                # syscall 4 (in chuỗi)
    syscall

end_num_to_text1:
    jr $ra                   # Trả về từ hàm

num_to_text:
    div $a0, $zero, 1000000 # Lấy a = num / 1000000
    mfhi $t0                # $t0 = num % 1000000
    div $t0, $zero, 1000    # Lấy b = (num % 1000000) / 1000
    mfhi $t1                # $t1 = (num % 1000000) % 1000
    beqz $a0, print_zero_a  # Nếu a = 0, in "khong"
    jal num_to_text1        # Gọi hàm num_to_text1 với tham số a
    li $v0, 4               # syscall 4 (in chuỗi)
    la  $a0, million        # $a0 = " trieu " (chuỗi tiếp theo)
    syscall
    beqz $t0, print_zero_b  # Nếu b = 0, in "khong"
    jal num_to_text1        # Gọi hàm num_to_text1 với tham số b
    li $v0, 4               # syscall 4 (in chuỗi)
    la $a0, thousand        # $a0 = " nghin " (chuỗi tiếp theo)
    syscall
    beqz $t1, end_num_to_text # Nếu c = 0, kết thúc
    jal num_to_text1        # Gọi hàm num_to_text1 với tham số c

print_zero_a:
    li $v0, 4               # syscall 4 (in chuỗi)
    la $a0, zero         # $a0 = "khong"
    syscall
    j end_num_to_text

print_zero_b:
    li $v0, 4               # syscall 4 (in chuỗi)
    la $a0, zero         # $a0 = "khong"
    syscall

end_num_to_text:
    jr $ra                  # Trả về từ hàm


