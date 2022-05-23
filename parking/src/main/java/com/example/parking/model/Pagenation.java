package com.example.parking.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Pagenation {

    private int totalPages; // 전체 페이지
    private int blockPage; // 페이지 묶음 단위
    private int startPage; // 페이지 시작 번호
    private int endPage;
    private int currentPage;

    public Pagenation(int count, int currentPage, int pageSize) {
        this.totalPages = count / pageSize + (count % pageSize == 0 ? 0 : 1);
        this.blockPage = 3;
        this.startPage = ((currentPage - 1) / blockPage * blockPage + 1);
        this.endPage = startPage + blockPage - 1;
        if (endPage > totalPages)
            this.endPage = totalPages;
        this.currentPage = currentPage;
    }

}
