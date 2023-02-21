import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: const Text('Mohamed Sakir', style: TextStyle(fontWeight: FontWeight.bold),),
            accountEmail: const Text("mhdsakir1999@gmail.com", style: TextStyle(fontWeight: FontWeight.bold)),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: ClipOval(                
                child: Image.asset(
                  'assets/prof.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage( 
                  fit: BoxFit.fill,
                  image: AssetImage('assets/back.jpg')),
            ),
          ),
          ListTile(
            leading: Icon(Icons.man),
            title: Text('Employees'),
            onTap: () => {Navigator.of(context).pop(),
              Navigator.pushReplacementNamed(context, '/employeeList')},
          ),

          ListTile(
            leading: Icon(Icons.home),
            title: Text('Departments'),
            onTap: () => {Navigator.of(context).pop(),
            Navigator.pushReplacementNamed(context, '/departmentList')
            },
          ),
                  
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add Employee'),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.pushReplacementNamed(context, '/addEmployee')  
            },
          ),
          
          
        ],
      ),
    );
  }
}