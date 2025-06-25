
 drop database lightcare_db;
 -- 데이터베이스 생성 (이미 존재하면 건너뛰기)
 
CREATE DATABASE IF NOT EXISTS lightcare_db;

-- 데이터베이스 사용
USE lightcare_db;

-- 1. Member 테이블 (MemberDTO 기반)
-- 기존 User, Manager, Caregiver 테이블의 역할을 통합하거나 대체할 수 있습니다.
CREATE TABLE `Member` (
    `member_id` BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '회원 ID',
    `user_id` VARCHAR(50) NOT NULL UNIQUE COMMENT '사용자 ID (로그인용)',
    `password` VARCHAR(255) NOT NULL COMMENT '비밀번호 (암호화된 값)',
    `name` VARCHAR(100) NOT NULL COMMENT '이름',
    `email` VARCHAR(100) NOT NULL UNIQUE COMMENT '이메일',
    `phone` VARCHAR(20) COMMENT '휴대폰 번호',
    `role` VARCHAR(20) DEFAULT 'USER' NOT NULL COMMENT '회원 역할 (USER, FACILITY, ADMIN 등)',
    `address` VARCHAR(255) COMMENT '주소',
    `profile_image` VARCHAR(255) COMMENT '프로필 이미지 경로',
    `is_active` TINYINT(1) DEFAULT 1 NOT NULL COMMENT '계정 활성화 여부 (0:비활성화, 1:활성화)',
    `login_fail_count` INT DEFAULT 0 NOT NULL COMMENT '로그인 실패 횟수',
    `last_login_at` DATETIME COMMENT '마지막 로그인 시간',
    
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '생성일시',
    `updated_at` DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
    `is_deleted` TINYINT(1) DEFAULT 0 NOT NULL COMMENT '삭제 여부 (0:정상, 1:삭제)'
);

-- 2. Facility 테이블 (FacilityDTO 기반)
-- 기존 Sanatorium 테이블의 역할을 대체합니다.
CREATE TABLE `Facility` (
    `facility_id` BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '시설 ID',
    `facility_name` VARCHAR(255) NOT NULL COMMENT '시설명',
    `facility_type` VARCHAR(50) NOT NULL COMMENT '시설 유형 (NURSING_HOME, HOSPITAL, DAY_CARE 등)',
    `address` VARCHAR(255) NOT NULL COMMENT '주소',
    `detail_address` VARCHAR(255) COMMENT '상세 주소',
    `phone` VARCHAR(20) NOT NULL COMMENT '전화번호',
    `latitude` DECIMAL(10, 8) COMMENT '위도',
    `longitude` DECIMAL(11, 8) COMMENT '경도',
    `description` TEXT COMMENT '시설 설명',
    `facility_image` VARCHAR(255) COMMENT '시설 이미지 경로',
    `homepage` VARCHAR(255) COMMENT '홈페이지 URL',
    `capacity` INT COMMENT '수용 인원',
    `current_occupancy` INT COMMENT '현재 입소자 수',
    `operating_hours` VARCHAR(255) COMMENT '운영 시간',
    `features` TEXT COMMENT '시설 특징',
    `average_rating` FLOAT COMMENT '평균 평점',
    `review_count` INT DEFAULT 0 COMMENT '리뷰 수',
    `registered_member_id` BIGINT NOT NULL COMMENT '등록한 회원 ID',
    `registered_member_name` VARCHAR(100) COMMENT '등록한 회원 이름', -- denormalization
    `is_approved` TINYINT(1) DEFAULT 0 NOT NULL COMMENT '승인 여부 (0:미승인, 1:승인)',
    `approval_status` VARCHAR(50) DEFAULT 'PENDING' NOT NULL COMMENT '승인 상태 (PENDING, APPROVED, REJECTED)',
    
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '생성일시',
    `updated_at` DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
    `is_deleted` TINYINT(1) DEFAULT 0 NOT NULL COMMENT '삭제 여부 (0:정상, 1:삭제)',

    -- 외부 키 제약 조건 (Member 테이블과 연결)
    CONSTRAINT `fk_facility_registered_member` FOREIGN KEY (`registered_member_id`) REFERENCES `Member` (`member_id`)
);

-- 3. Board 테이블 (BoardDTO 기반)
CREATE TABLE `Board` (
    `board_id` BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '게시글 ID',
    `board_type` VARCHAR(50) NOT NULL COMMENT '게시판 유형 (NOTICE, INFO, QNA, FAQ)',
    `title` VARCHAR(255) NOT NULL COMMENT '제목',
    `content` TEXT NOT NULL COMMENT '내용',
    `member_id` BIGINT NOT NULL COMMENT '작성자 ID',
    `member_name` VARCHAR(100) COMMENT '작성자 이름', -- denormalization
    `author` VARCHAR(100) COMMENT '작성자 표시명',
    `view_count` INT DEFAULT 0 NOT NULL COMMENT '조회수',
    `like_count` INT DEFAULT 0 NOT NULL COMMENT '추천수',
    `comment_count` INT DEFAULT 0 NOT NULL COMMENT '댓글수',
    `attachment_path` VARCHAR(255) COMMENT '첨부파일 경로',
    `attachment_name` VARCHAR(255) COMMENT '첨부파일 원본명',
    `attachment_size` BIGINT COMMENT '첨부파일 크기',
    `is_notice` TINYINT(1) DEFAULT 0 NOT NULL COMMENT '공지사항 여부',
    `is_secret` TINYINT(1) DEFAULT 0 NOT NULL COMMENT '비밀글 여부',
    `is_active` TINYINT(1) DEFAULT 1 NOT NULL COMMENT '활성 상태',
    `status` VARCHAR(50) DEFAULT 'ACTIVE' NOT NULL COMMENT '상태 (ACTIVE, HIDDEN, DELETED)',
    `category` VARCHAR(50) COMMENT '카테고리',
    `sub_category` VARCHAR(50) COMMENT '서브 카테고리',
    `priority` INT DEFAULT 0 NOT NULL COMMENT '우선순위 (상단 고정용)',
    `is_pinned` TINYINT(1) DEFAULT 0 NOT NULL COMMENT '상단 고정 여부',
    `parent_board_id` BIGINT COMMENT '부모 게시글 ID (답글인 경우)',
    `reply_depth` INT DEFAULT 0 NOT NULL COMMENT '답글 깊이',
    `reply_order` INT DEFAULT 0 NOT NULL COMMENT '답글 순서',
    `tags` VARCHAR(255) COMMENT '태그 (콤마로 구분)',
    `meta_description` VARCHAR(255) COMMENT '메타 설명',
    `meta_keywords` VARCHAR(255) COMMENT '메타 키워드',
    
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '생성일시',
    `updated_at` DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
    `is_deleted` TINYINT(1) DEFAULT 0 NOT NULL COMMENT '삭제 여부 (0:정상, 1:삭제)',

    -- 외부 키 제약 조건 (Member 테이블과 연결)
    CONSTRAINT `fk_board_member` FOREIGN KEY (`member_id`) REFERENCES `Member` (`member_id`),
    -- 자기 참조 외부 키 (답글 기능)
    CONSTRAINT `fk_board_parent_board` FOREIGN KEY (`parent_board_id`) REFERENCES `Board` (`board_id`)
);

-- 4. Job 테이블 (JobDTO 기반)
CREATE TABLE `Job` (
    `job_id` BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '구인구직 ID',
    `title` VARCHAR(255) NOT NULL COMMENT '제목',
    `content` TEXT NOT NULL COMMENT '내용',
    `job_type` VARCHAR(50) NOT NULL COMMENT '구인구직 유형 (RECRUIT: 구인, SEARCH: 구직)',
    `work_type` VARCHAR(50) NOT NULL COMMENT '근무 형태 (FULL_TIME, PART_TIME, TEMPORARY)',
    `position` VARCHAR(100) COMMENT '모집 직종',
    `recruit_count` INT COMMENT '모집 인원',
    `salary_type` VARCHAR(50) COMMENT '급여 유형 (HOURLY, MONTHLY, ANNUAL)',
    `salary_min` DECIMAL(15, 2) COMMENT '최소 급여',
    `salary_max` DECIMAL(15, 2) COMMENT '최대 급여',
    `salary_description` VARCHAR(255) COMMENT '급여 설명',
    `work_location` VARCHAR(255) COMMENT '근무 지역',
    `work_hours` VARCHAR(255) COMMENT '근무 시간',
    `experience` VARCHAR(255) COMMENT '경력 조건',
    `education` VARCHAR(255) COMMENT '학력 조건',
    `qualifications` TEXT COMMENT '자격 요건',
    `benefits` TEXT COMMENT '복리후생',
    `start_date` DATE COMMENT '모집 시작일',
    `end_date` DATE COMMENT '모집 마감일',
    `contact_name` VARCHAR(100) COMMENT '담당자 이름',
    `contact_phone` VARCHAR(20) COMMENT '담당자 연락처',
    `contact_email` VARCHAR(255) COMMENT '담당자 이메일',
    `status` VARCHAR(50) DEFAULT 'ACTIVE' NOT NULL COMMENT '게시글 상태 (ACTIVE, CLOSED, DRAFT)',
    `view_count` INT DEFAULT 0 NOT NULL COMMENT '조회수',
    `apply_count` INT DEFAULT 0 NOT NULL COMMENT '지원자 수',
    `member_id` BIGINT NOT NULL COMMENT '작성자 ID',
    `member_name` VARCHAR(100) COMMENT '작성자 이름', -- denormalization
    `facility_id` BIGINT COMMENT '관련 시설 ID',
    `facility_name` VARCHAR(255) COMMENT '시설 이름', -- denormalization
    `priority` INT DEFAULT 0 NOT NULL COMMENT '우선순위',
    `is_highlight` TINYINT(1) DEFAULT 0 NOT NULL COMMENT '강조 표시 여부',
    `attachment_path` VARCHAR(255) COMMENT '첨부파일 경로',
    `attachment_name` VARCHAR(255) COMMENT '첨부파일 원본명',
    
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '생성일시',
    `updated_at` DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
    `is_deleted` TINYINT(1) DEFAULT 0 NOT NULL COMMENT '삭제 여부 (0:정상, 1:삭제)',

    -- 외부 키 제약 조건 (Member 테이블과 연결)
    CONSTRAINT `fk_job_member` FOREIGN KEY (`member_id`) REFERENCES `Member` (`member_id`),
    -- 외부 키 제약 조건 (Facility 테이블과 연결 - 구인글인 경우)
    CONSTRAINT `fk_job_facility` FOREIGN KEY (`facility_id`) REFERENCES `Facility` (`facility_id`)
);

-- 5. Review 테이블 (ReviewDTO 기반)
CREATE TABLE `Review` (
    `review_id` BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '리뷰 ID',
    `facility_id` BIGINT NOT NULL COMMENT '시설 ID',
    `facility_name` VARCHAR(255) COMMENT '시설 이름', -- denormalization
    `member_id` BIGINT NOT NULL COMMENT '작성자 ID',
    `member_name` VARCHAR(100) COMMENT '작성자 이름', -- denormalization
    `title` VARCHAR(255) NOT NULL COMMENT '리뷰 제목',
    `content` TEXT NOT NULL COMMENT '리뷰 내용',
    `rating` INT NOT NULL COMMENT '평점 (1-5점)',
    `service_rating` INT COMMENT '서비스 평점',
    `facility_rating` INT COMMENT '시설 평점',
    `staff_rating` INT COMMENT '직원 평점',
    `price_rating` INT COMMENT '가격 평점',
    `review_image1` VARCHAR(255) COMMENT '리뷰 이미지 1 경로',
    `review_image2` VARCHAR(255) COMMENT '리뷰 이미지 2 경로',
    `review_image3` VARCHAR(255) COMMENT '리뷰 이미지 3 경로',
    `like_count` INT DEFAULT 0 NOT NULL COMMENT '추천 수',
    `dislike_count` INT DEFAULT 0 NOT NULL COMMENT '비추천 수',
    `view_count` INT DEFAULT 0 NOT NULL COMMENT '조회수',
    `is_visible` TINYINT(1) DEFAULT 1 NOT NULL COMMENT '표시 여부 (0:숨김, 1:표시)',
    `status` VARCHAR(50) DEFAULT 'ACTIVE' NOT NULL COMMENT '상태 (ACTIVE, HIDDEN, REPORTED)',
    `parent_review_id` BIGINT COMMENT '부모 리뷰 ID (답글인 경우)',
    `reply_count` INT DEFAULT 0 NOT NULL COMMENT '답글 수',
    `reply_depth` INT DEFAULT 0 NOT NULL COMMENT '답글 깊이',
    
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '생성일시',
    `updated_at` DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
    `is_deleted` TINYINT(1) DEFAULT 0 NOT NULL COMMENT '삭제 여부 (0:정상, 1:삭제)',

    -- 외부 키 제약 조건 (Facility 테이블과 연결)
    CONSTRAINT `fk_review_facility` FOREIGN KEY (`facility_id`) REFERENCES `Facility` (`facility_id`),
    -- 외부 키 제약 조건 (Member 테이블과 연결)
    CONSTRAINT `fk_review_member` FOREIGN KEY (`member_id`) REFERENCES `Member` (`member_id`),
    -- 자기 참조 외부 키 (리뷰 답글 기능)
    CONSTRAINT `fk_review_parent_review` FOREIGN KEY (`parent_review_id`) REFERENCES `Review` (`review_id`)
);
