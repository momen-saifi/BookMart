-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 20, 2024 at 05:58 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ebook-app`
--

-- --------------------------------------------------------

--
-- Table structure for table `book_dtls`
--

CREATE TABLE `book_dtls` (
  `bookId` int(11) NOT NULL,
  `bookname` varchar(45) DEFAULT NULL,
  `author` varchar(45) DEFAULT NULL,
  `price` varchar(45) DEFAULT NULL,
  `bookCategory` varchar(45) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `photo` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `quantity` int(11) NOT NULL DEFAULT 0
) ;

--
-- Dumping data for table `book_dtls`
--

INSERT INTO `book_dtls` (`bookId`, `bookname`, `author`, `price`, `bookCategory`, `status`, `photo`, `email`, `quantity`) VALUES
(50, 'JAVA', 'JOSH TOMPSONS', '300', 'New', 'Active', 'java.jpg', 'momensaifi02@gmail.com', 5),
(51, 'Let Us C', 'Yashvant Kanetkar', '350', 'New', 'Active', 'c_progamming.jpg', 'momensaifi02@gmail.com', 9),
(52, 'C programming', 'Dennis M.Ritchie', '250', 'New', 'Active', 'c_progamming2.jpg', 'momensaifi02@gmail.com', 2),
(53, 'C++ ', 'Warren Dittman', '500', 'New', 'Active', 'c++.jpg', 'momensaifi02@gmail.com', 100),
(54, 'Computer Fundamentals', 'Priti Sinha', '299', 'New', 'Active', 'cf.jpg', 'momensaifi02@gmail.com', 0),
(55, 'The Coding', 'Michael Clark', '400', 'New', 'Active', 'coding.jpg', 'momensaifi02@gmail.com', 2),
(56, 'Fundamentals Of Data Sciences', 'Samuel Burns', '800', 'New', 'Active', 'datascience.jpg', 'momensaifi02@gmail.com', 1),
(57, 'DBMS', 'Dr. P. Keerthika', '200', 'New', 'Active', 'dbms.jpg', 'momensaifi02@gmail.com', 12),
(58, 'Data Structures And Algo', 'Prof. Dipannita Mondal', '450', 'New', 'Active', 'dsa1.jpg', 'momensaifi02@gmail.com', 300),
(59, 'Harry Potter ', 'J.K. Rowling', '500', 'New', 'Active', 'harry_potter.jpg', 'momensaifi02@gmail.com', 47),
(60, 'Computer Science with Python', 'Sumita Arora', '350', 'New', 'Active', 'python2.jpg', 'momensaifi02@gmail.com', 98),
(61, 'Storybook B', 'TarGet', '99', 'New', 'Active', 'story2.jpg', 'momensaifi02@gmail.com', 6),
(62, 'Linux', 'Dylan Mach', '240', 'Old', 'Active', 'linux.jpg', 'momensaifi63@gmail.com', 2),
(63, 'Data Structures', 'Warren Dittman', '400', 'Old', 'Active', 'dsa2.jpg', 'momensaifi63@gmail.com', 1),
(64, 'Functional Programming', 'Dimitris Papadimitriou', '450', 'Old', 'Active', 'js.jpg', 'momensaifi63@gmail.com', 1),
(65, 'Storybook A', 'TarGet', '99', 'Old', 'Active', 'story3.jpg', 'momensaifi63@gmail.com', 10),
(66, 'Mastering TypeScript', 'Nathan Rozentals', '550', 'Old', 'Active', 'typescript.jpg', 'momensaifi63@gmail.com', 2),
(67, 'Adventure in North Pole', 'Arjit Jha', '199', 'Old', 'Active', 'story.jpg', 'momensaifi63@gmail.com', 1),
(68, 'SQL Queries', 'Clare Churcher', '150', 'Old', 'Active', 'sql.jpg', 'momensaifi63@gmail.com', 1),
(69, 'Python Programming', 'Sumita Arora', '299', 'Old', 'Active', 'python2.jpg', 'momensaifi63@gmail.com', 1);

-- --------------------------------------------------------

--
-- Table structure for table `book_order`
--

CREATE TABLE `book_order` (
  `id` int(11) NOT NULL,
  `order_id` varchar(45) NOT NULL,
  `user_name` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `phno` varchar(45) DEFAULT NULL,
  `payment` varchar(45) DEFAULT NULL,
  `price` varchar(45) NOT NULL DEFAULT '0.00',
  `order_timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `book_order`
--

INSERT INTO `book_order` (`id`, `order_id`, `user_name`, `email`, `phno`, `payment`, `price`, `order_timestamp`) VALUES
(133, 'BOOK-ORD-000', 'Momen Saifi', 'momensaifi63@gmail.com', '8218770000', 'cod', '1750.0', '2024-05-14 04:26:47'),
(134, 'BOOK-ORD-00133', 'Momen Saifi', 'momensaifi63@gmail.com', '8218770000', 'cod', '1500.0', '2024-05-14 04:37:01'),
(135, 'BOOK-ORD-00134', 'Momen Saifi', 'momensaifi63@gmail.com', '8218770000', 'cod', '2050.0', '2024-05-15 06:22:46'),
(136, 'BOOK-ORD-00135', 'Momen Saifi', 'momensaifi63@gmail.com', '8218770000', 'cod', '797.0', '2024-05-17 06:02:24'),
(137, 'BOOK-ORD-00136', 'Momen Saifi', 'momensaifi63@gmail.com', '8218770000', 'cod', '400.0', '2024-05-17 08:07:27'),
(138, 'BOOK-ORD-00137', 'Momen Saifi', 'momensaifi63@gmail.com', '8218770001', 'cod', '198.0', '2024-05-17 09:22:45'),
(139, 'BOOK-ORD-00138', 'Momen Saifi', 'momensaifi63@gmail.com', '8218770000', 'cod', '198.0', '2024-05-20 09:22:11'),
(140, 'BOOK-ORD-00139', 'Momen Saifi', 'momensaifi63@gmail.com', '8218770000', 'cod', '99.0', '2024-05-20 09:23:34');

-- --------------------------------------------------------

--
-- Table structure for table `book_order_details`
--

CREATE TABLE `book_order_details` (
  `id` int(11) NOT NULL,
  `book_name` varchar(45) DEFAULT NULL,
  `author` varchar(45) DEFAULT NULL,
  `price` varchar(45) DEFAULT NULL,
  `order_id` varchar(45) NOT NULL,
  `order_timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `quantity` int(11) NOT NULL DEFAULT 0,
  `bid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `book_order_details`
--

INSERT INTO `book_order_details` (`id`, `book_name`, `author`, `price`, `order_id`, `order_timestamp`, `quantity`, `bid`) VALUES
(28, 'Let Us C', 'Yashvant Kanetkar', '350.0', 'BOOK-ORD-000', '2024-05-14 04:26:47', 1, 51),
(29, 'Computer Science with Python', 'Sumita Arora', '700.0', 'BOOK-ORD-000', '2024-05-14 04:26:47', 2, 60),
(30, 'Harry Potter ', 'J.K. Rowling', '1500.0', 'BOOK-ORD-00133', '2024-05-14 04:37:01', 3, 59),
(31, 'Computer Science with Python', 'Sumita Arora', '700.0', 'BOOK-ORD-00134', '2024-05-15 06:22:46', 2, 60),
(32, 'Harry Potter ', 'J.K. Rowling', '1000.0', 'BOOK-ORD-00134', '2024-05-15 06:22:46', 2, 59),
(33, 'Harry Potter ', 'J.K. Rowling', '500.0', 'BOOK-ORD-00135', '2024-05-17 06:02:24', 1, 59),
(34, 'Storybook B', 'TarGet', '198.0', 'BOOK-ORD-00135', '2024-05-17 06:02:24', 2, 61),
(35, 'The Coding', 'Michael Clark', '400.0', 'BOOK-ORD-00136', '2024-05-17 08:07:27', 1, 55),
(36, 'Storybook B', 'TarGet', '198.0', 'BOOK-ORD-00137', '2024-05-17 09:22:45', 2, 61),
(37, 'Storybook B', 'TarGet', '198.0', 'BOOK-ORD-00138', '2024-05-20 09:22:11', 2, 61),
(38, 'Storybook B', 'TarGet', '99.0', 'BOOK-ORD-00139', '2024-05-20 09:23:34', 1, 61);

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `cid` int(11) NOT NULL,
  `bid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `bookName` varchar(45) NOT NULL,
  `author` varchar(45) NOT NULL,
  `price` double NOT NULL,
  `total_price` double NOT NULL,
  `piece_count` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`cid`, `bid`, `uid`, `bookName`, `author`, `price`, `total_price`, `piece_count`) VALUES
(355, 59, 15, 'Harry Potter ', 'J.K. Rowling', 500, 500, 1),
(356, 58, 15, 'Data Structures And Algo', 'Prof. Dipannita Mondal', 450, 900, 2);

-- --------------------------------------------------------

--
-- Table structure for table `orders_cancel`
--

CREATE TABLE `orders_cancel` (
  `id` int(11) NOT NULL,
  `order_id` varchar(45) NOT NULL,
  `cancel_timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders_cancel`
--

INSERT INTO `orders_cancel` (`id`, `order_id`, `cancel_timestamp`) VALUES
(18, 'BOOK-ORD-00133', '2024-05-14 04:42:02'),
(19, 'BOOK-ORD-00134', '2024-05-15 06:23:19'),
(20, 'BOOK-ORD-00135', '2024-05-17 08:08:37');

-- --------------------------------------------------------

--
-- Table structure for table `orders_dispatched`
--

CREATE TABLE `orders_dispatched` (
  `id` int(11) NOT NULL,
  `order_id` varchar(45) NOT NULL,
  `dispatched_timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders_dispatched`
--

INSERT INTO `orders_dispatched` (`id`, `order_id`, `dispatched_timestamp`) VALUES
(29, 'BOOK-ORD-00136', '2024-05-17 09:25:26');

-- --------------------------------------------------------

--
-- Table structure for table `orders_shipped`
--

CREATE TABLE `orders_shipped` (
  `id` int(11) NOT NULL,
  `order_id` varchar(45) NOT NULL,
  `shipped_timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders_shipped`
--

INSERT INTO `orders_shipped` (`id`, `order_id`, `shipped_timestamp`) VALUES
(20, 'BOOK-ORD-000', '2024-05-14 04:41:45'),
(21, 'BOOK-ORD-00139', '2024-05-20 09:24:53');

-- --------------------------------------------------------

--
-- Table structure for table `order_address`
--

CREATE TABLE `order_address` (
  `id` int(11) NOT NULL,
  `address` varchar(45) DEFAULT NULL,
  `landmark` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `pincode` varchar(45) DEFAULT NULL,
  `order_id` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_address`
--

INSERT INTO `order_address` (`id`, `address`, `landmark`, `city`, `state`, `pincode`, `order_id`) VALUES
(21, 'Hapur', 'Hapur', 'Hapur', 'U.P.', '245101', 'BOOK-ORD-000'),
(22, 'Hapur', 'Hapur', 'Hapur', 'U.P.', '245101', 'BOOK-ORD-00133'),
(23, 'Hapur', 'Hapur', 'Hapur', 'U.P.', '245101', 'BOOK-ORD-00134'),
(24, 'Hapur', 'Hapur', 'Hapur', 'U.P.', '245101', 'BOOK-ORD-00135'),
(25, 'Hapur', 'Hapur', 'Hapur', 'U.P.', '245101', 'BOOK-ORD-00136'),
(26, 'Hapur', 'Hapur', 'Hapur', 'U.P.', '245201', 'BOOK-ORD-00137'),
(27, 'Hapur', 'Hapur', 'Hapur', 'U.P.', '245101', 'BOOK-ORD-00138'),
(28, 'delhi', 'Hapur', 'Hapur', 'U.P.', '245101', 'BOOK-ORD-00139');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `phno` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `usertype` varchar(50) DEFAULT 'normal',
  `status` varchar(10) NOT NULL DEFAULT 'Active'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `email`, `phno`, `password`, `usertype`, `status`) VALUES
(12, 'Momen', 'momensaifi02@gmail.com', '8218770000', 'Admin@321', 'admin', 'Active'),
(13, 'Momen Saifi', 'momensaifi63@gmail.com', '8218770000', 'Pass@123', 'normal', 'Active'),
(15, 'Swagatika', 'hialswagatika@gmail.com', '9861281577', 'Pass@123', 'normal', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `user_address`
--

CREATE TABLE `user_address` (
  `id` int(11) NOT NULL,
  `address` varchar(45) DEFAULT NULL,
  `landmark` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `pincode` varchar(45) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_address`
--

INSERT INTO `user_address` (`id`, `address`, `landmark`, `city`, `state`, `pincode`, `userid`) VALUES
(6, 'Hapur', 'Hapur', 'Hapur', 'U.P.', '245101', 13);

-- --------------------------------------------------------

--
-- Table structure for table `wish_list`
--

CREATE TABLE `wish_list` (
  `wid` int(11) NOT NULL,
  `bid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `bookName` varchar(255) NOT NULL,
  `author` varchar(100) NOT NULL,
  `price` double(10,2) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `photo` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `wish_list`
--

INSERT INTO `wish_list` (`wid`, `bid`, `uid`, `bookName`, `author`, `price`, `date_added`, `photo`) VALUES
(33, 50, 12, 'JAVA', 'JOSH TOMPSONS', 300.00, '2024-05-13 20:27:01', 'java.jpg'),
(35, 59, 13, 'Harry Potter ', 'J.K. Rowling', 500.00, '2024-05-14 04:20:43', 'harry_potter.jpg'),
(36, 58, 13, 'Data Structures And Algo', 'Prof. Dipannita Mondal', 450.00, '2024-05-14 04:20:46', 'dsa1.jpg'),
(39, 54, 13, 'Computer Fundamentals', 'Priti Sinha', 299.00, '2024-05-14 04:25:37', 'cf.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `book_dtls`
--
ALTER TABLE `book_dtls`
  ADD PRIMARY KEY (`bookId`);

--
-- Indexes for table `book_order`
--
ALTER TABLE `book_order`
  ADD PRIMARY KEY (`order_id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD UNIQUE KEY `id_2` (`id`),
  ADD UNIQUE KEY `id_3` (`id`);

--
-- Indexes for table `book_order_details`
--
ALTER TABLE `book_order_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `fk_cart_user` (`uid`);

--
-- Indexes for table `orders_cancel`
--
ALTER TABLE `orders_cancel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `orders_dispatched`
--
ALTER TABLE `orders_dispatched`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `orders_shipped`
--
ALTER TABLE `orders_shipped`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `order_address`
--
ALTER TABLE `order_address`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_address`
--
ALTER TABLE `user_address`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_userid` (`userid`);

--
-- Indexes for table `wish_list`
--
ALTER TABLE `wish_list`
  ADD PRIMARY KEY (`wid`),
  ADD KEY `fk_wishlist_user` (`uid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `book_dtls`
--
ALTER TABLE `book_dtls`
  MODIFY `bookId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `book_order`
--
ALTER TABLE `book_order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=141;

--
-- AUTO_INCREMENT for table `book_order_details`
--
ALTER TABLE `book_order_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `cid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=359;

--
-- AUTO_INCREMENT for table `orders_cancel`
--
ALTER TABLE `orders_cancel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `orders_dispatched`
--
ALTER TABLE `orders_dispatched`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `orders_shipped`
--
ALTER TABLE `orders_shipped`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `order_address`
--
ALTER TABLE `order_address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `user_address`
--
ALTER TABLE `user_address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `wish_list`
--
ALTER TABLE `wish_list`
  MODIFY `wid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `book_order_details`
--
ALTER TABLE `book_order_details`
  ADD CONSTRAINT `book_order_details_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `book_order` (`order_id`);

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `fk_cart_user` FOREIGN KEY (`uid`) REFERENCES `user` (`id`);

--
-- Constraints for table `orders_cancel`
--
ALTER TABLE `orders_cancel`
  ADD CONSTRAINT `orders_cancel_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `book_order` (`order_id`);

--
-- Constraints for table `orders_dispatched`
--
ALTER TABLE `orders_dispatched`
  ADD CONSTRAINT `orders_dispatched_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `book_order` (`order_id`);

--
-- Constraints for table `orders_shipped`
--
ALTER TABLE `orders_shipped`
  ADD CONSTRAINT `orders_shipped_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `book_order` (`order_id`);

--
-- Constraints for table `order_address`
--
ALTER TABLE `order_address`
  ADD CONSTRAINT `order_address_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `book_order` (`order_id`);

--
-- Constraints for table `user_address`
--
ALTER TABLE `user_address`
  ADD CONSTRAINT `fk_user_address_userid` FOREIGN KEY (`userid`) REFERENCES `user` (`id`);

--
-- Constraints for table `wish_list`
--
ALTER TABLE `wish_list`
  ADD CONSTRAINT `fk_wishlist_user` FOREIGN KEY (`uid`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
