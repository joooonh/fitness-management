<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<ul class="navbar-nav flex-column mt-4" id="open-submenu">
	<li class="nav-item mb-2">
		<a href="../admin/member" class="nav-link text-white p-3 mb-2 sidebar-link">
			<i class="bi bi-people-fill"></i> 회원관리
		</a>
	</li>
	<li class="nav-item mb-2">
		<a href="" class="nav-link text-white p-3 mb-2 sidebar-link">
			<i class="bi bi-shop-window"></i> 매장관리
		</a>
	</li>
	<li class="nav-item mb-2">
		<a href="" class="nav-link text-white p-3 mb-2 sidebar-link">
			<i class="bi bi-pc-display-horizontal"></i> 프로그램관리
		</a>
		<ul class="submenu  mb-2">
			<a href="/admin/program/list" class="nav-link text-white">프로그램 조회</a>
			<a href="" class="nav-link text-white">프로그램 등록</a>
		</ul>
	</li>
	<li class="nav-item mb-2">
		<a href="" class="nav-link text-white p-3 mb-2 sidebar-link">
			<i class="bi bi-person-video"></i> 직원관리
		</a>
		<ul class="submenu  mb-2">
			<a href="" class="nav-link text-white">하위메뉴</a>
			<a href="" class="nav-link text-white">하위메뉴</a>
			<a href="" class="nav-link text-white">하위메뉴</a>
		</ul>
	</li>
	<li class="nav-item mb-2">
		<a href="" class="nav-link text-white p-3 mb-2 sidebar-link">
			<i class="bi bi-card-checklist"></i> 출석관리
		</a>
		<ul class="submenu  mb-2">
			<a href="" class="nav-link text-white">하위메뉴</a>
			<a href="" class="nav-link text-white">하위메뉴</a>
			<a href="" class="nav-link text-white">하위메뉴</a>
		</ul>
	</li>
	<li class="nav-item mb-2">
		<a href="" class="nav-link text-white p-3 mb-2 sidebar-link">
			<i class="bi bi-calendar-check"></i> 예약관리
		</a>
		<ul class="submenu  mb-2">
			<a href="" class="nav-link text-white">하위메뉴</a>
			<a href="" class="nav-link text-white">하위메뉴</a>
			<a href="" class="nav-link text-white">하위메뉴</a>
		</ul>
	</li>
	<li class="nav-item mb-2">
		<a href="" class="nav-link text-white p-3 mb-2 sidebar-link">
			<i class="bi bi-calendar3"></i> 일정관리
		</a>
		<ul class="submenu  mb-2">
			<a href="" class="nav-link text-white">하위메뉴</a>
			<a href="" class="nav-link text-white">하위메뉴</a>
			<a href="" class="nav-link text-white">하위메뉴</a>
		</ul>
	</li>
	<li class="nav-item mb-2">
		<a href="" class="nav-link text-white p-3 mb-2 sidebar-link">
			<i class="bi bi-graph-up-arrow"></i> 매출통계
		</a>
		<ul class="submenu mb-2">
			<a href="" class="nav-link text-white">하위메뉴</a>
			<a href="" class="nav-link text-white">하위메뉴</a>
			<a href="" class="nav-link text-white">하위메뉴</a>
		</ul>
	</li>
</ul>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
$(function(){
	$(".submenu").hide();
	
	$("#open-submenu li").hover(function(){
		$(this).addClass("current");
		$(this).children("ul").show(500);
		
	}, function(){
		$(this).removeClass("current");
		$(this).children("ul").hide(500);
	})
})
</script>