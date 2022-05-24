package com.example.parking.model;

import org.springframework.data.domain.Page;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Pagenation {

    private int currentPage; // 현재 페이지 번호
    private int perPage; // 한 페이지당 게시되는 게시물 수
    private int pageSize; // 페이지 리스트에 게시되는 페이지 링크 수
    private int totalRecordCount; // 전체 게시물 수
    private int startPage; // 보여지는 페이지 리스트의 시작 페이지 번호
    private int endPage; // 보여지는 페이지 리스트의 마지막 페이지 번호
    private int totalPages; // 페이지 리스트 총 개수, 실제 페이지 리스트의 마지막
    // private int pageNum; // 선택된 페이지 번호
    private boolean prev; // 이전 버튼
    private boolean next; // 다음 버튼

    public Pagenation(Page page) {
        System.out.println(">>" + page.getNumber());
        this.perPage = page.getSize();
        this.totalRecordCount = (int) page.getTotalElements();
        this.currentPage = page.getNumber() + 1;
        this.pageSize = 2;
        this.totalPages = page.getTotalPages();
        this.startPage = ((currentPage - 1) / pageSize * pageSize + 1);
        this.endPage = startPage + pageSize - 1;
        if (endPage > totalPages)
            this.endPage = totalPages;
    }

    // (2-1)/2*2+1
    public boolean getPrev() {
        prev = getStartPage() > 1;
        return prev;
    }

    public boolean getNext() {
        next = getEndPage() < getTotalPages();
        return next;
    }

}
